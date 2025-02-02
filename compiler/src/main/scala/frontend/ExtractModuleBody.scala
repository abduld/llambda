package io.llambda.compiler.frontend
import io.llambda

import llambda.compiler._
import llambda.compiler.{valuetype => vt}
import llambda.compiler.frontend.syntax.ExpandMacro

object ExtractModuleBody {
  private def extractInclude(
      located : SourceLocated,
      scope : Scope,
      includeNameData : List[sst.ScopedDatum],
      foldCase : Boolean = false
  )(implicit context : FrontendContext) : List[et.Expr] = {
    val includeData = ResolveIncludeList(located, includeNameData.map(_.unscope))(context.config.includePath)

    val foldedData = if (foldCase) {
      includeData.map(_.toCaseFolded)
    }
    else {
      includeData
    }

    ExtractModuleBody(foldedData, scope)
  }

  private def handleExtractedDefine(
      located : SourceLocated,
      extractedDefine : ExtractedVarsDefine
  )(implicit context : FrontendContext) : List[et.Expr] = extractedDefine match {
    case ExtractedVarsDefine(List(valueTarget), None, exprBlock) =>
      val symbol = valueTarget.definedSymbol

      // There's a wart in Scheme that allows a top-level (define) to become a (set!) if the value is already defined as
      // a storage location
      symbol.resolveOpt match {
        case Some(_) if !context.config.schemeDialect.allowTopLevelRedefinition =>
          throw new DuplicateDefinitionException(symbol)

        case Some(storageLoc : StorageLocation) =>
          if (storageLoc.forceImmutable) {
            throw new BadSpecialFormException(symbol, s"Attempted mutating (define) of immutable binding ${symbol.name}")
          }
          else {
            // Convert this to a (set!)
            List(et.MutateVar(storageLoc, exprBlock()))
          }

        case Some(_) =>
          throw new BadSpecialFormException(symbol, s"Attempted mutating (define) non-variable ${symbol.name}")

        case None =>
          // This is a fresh binding
          val boundValue = valueTarget.bindStorageLoc(vt.AnySchemeType)
          List(et.TopLevelDefine(et.SingleBinding(boundValue, exprBlock())))
      }

    case ExtractedVarsDefine(fixedValueTargets, restValueTargetOpt, exprBlock) =>
      // Don't support re-defining top-level values with (define-values) in any dialect
      for (symbol <- (fixedValueTargets ++ restValueTargetOpt).map(_.definedSymbol)) {
        if (symbol.resolveOpt.isDefined) {
          throw new DuplicateDefinitionException(symbol)
        }
      }

      val fixedLocs = fixedValueTargets.map(_.bindStorageLoc(vt.AnySchemeType))
      val restLocOpt = restValueTargetOpt.map(_.bindStorageLoc(vt.UniformProperListType(vt.AnySchemeType)))

      List(et.TopLevelDefine(et.Binding(fixedLocs, restLocOpt, exprBlock())))
  }

  private def extractOutermostExpr(
      datum : sst.ScopedDatum
  )(implicit context : FrontendContext) : List[et.Expr] = datum match {
    case sst.ScopedPair(appliedSymbol : sst.ScopedSymbol, cdr) =>
      (appliedSymbol.resolve, cdr) match {
        case (syntax : BoundSyntax, _) =>
          // This is a macro - expand it
          val expandedDatum = ExpandMacro(syntax, cdr, datum, trace=context.config.traceMacroExpansion)
          extractOutermostExpr(expandedDatum)

        case (Primitives.Begin, sst.ScopedProperList(innerExprData)) =>
          // This is a (begin) - flatten it
          innerExprData.flatMap(extractOutermostExpr)

        case (Primitives.Include, sst.ScopedProperList(includeNames)) =>
          // We need the scope from the (include) to rescope the included file
          val scope = appliedSymbol.scope
          extractInclude(appliedSymbol, scope, includeNames)

        case (Primitives.IncludeCI, sst.ScopedProperList(includeNames)) =>
          val scope = appliedSymbol.scope
          extractInclude(appliedSymbol, scope, includeNames, foldCase=true)

        case (definePrimitive : PrimitiveDefineExpr, sst.ScopedProperList(operands)) =>
          val allowRedefinition = context.config.schemeDialect.allowTopLevelRedefinition

          ExtractDefine(datum, definePrimitive, operands, allowRedefinition).flatMap { define =>
            handleExtractedDefine(datum, define)
          }

        case _ =>
          ExtractExpr(datum).toSequence
      }

    case _ =>
      ExtractExpr(datum).toSequence
  }

  /** Converts the body of a module (library or program) to a list of expressions
    *
    * @param  data       Scheme date of the module's body
    * @param  evalScope  Scope to evaluate the body in
    */
  def apply(data : List[ast.Datum], evalScope : Scope)(implicit context : FrontendContext) : List[et.Expr] =
    data flatMap { datum =>
      // Annotate our symbols with our current scope
      val scopedDatum = sst.ScopedDatum(evalScope, datum)
      extractOutermostExpr(scopedDatum)
    }
}
