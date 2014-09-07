package io.llambda.compiler.planner
import io.llambda

import collection.mutable

import llambda.compiler.ProcedureSignature
import llambda.compiler.ast
import llambda.compiler.planner.{step => ps}
import llambda.compiler.planner.{intermediatevalue => iv}
import llambda.compiler.{celltype => ct}
import llambda.compiler.{valuetype => vt}
import llambda.compiler.codegen.AdaptedProcedureSignature
import llambda.compiler.{RuntimeErrorMessage, ContextLocated}

import llambda.compiler.valuetype.Implicits._

private[planner] object PlanProcedureTrampoline {
  /** Plans a trampoline for the passed procedure 
    * 
    * All trampolines have AdaptedProcedureSignature which means they can be called without knowing the signature of the
    * underlying procedure. It is assumed the argument list a proper list; it is inappropriate to pass user provided
    * arguments lists to a trampoline without confirming the list is proper beforehand.
    *
    * @param  invokableProc     The target procedure. The trampoline will ensure the arguments it's passed satisfy
    *                           the target procedure's signature and perform any required type conversions. 
    * @param  targetProcLocOpt  Source location of the target procedure. This is used to generate a comment in the 
    *                           output IR identifying the trampoline.
    */
  def apply(
      invokableProc : InvokableProcedure,
      nativeSymbol : String,
      targetProcLocOpt : Option[ContextLocated] = None
  )(implicit parentPlan : PlanWriter) : PlannedFunction = {
    val worldPtrTemp = new ps.WorldPtrValue
    val selfTemp = ps.CellTemp(ct.ProcedureCell)
    val argListHeadTemp = ps.CellTemp(ct.ListElementCell)
    val signature = invokableProc.signature

    implicit val plan = parentPlan.forkPlan()

    // Change our argListHeadTemp to a IntermediateValue
    val argListType = vt.UniformProperListType(vt.AnySchemeType)
    val argListValue = TempValueToIntermediate(argListType, argListHeadTemp)(parentPlan.config)

    val resultValues = PlanInvokeApply.withArgumentList(
      invokableProc=invokableProc,
      argListValue=argListValue,
      selfTempOverride=Some(selfTemp)
    )(plan, worldPtrTemp)

    val returnTempOpt = resultValues.toReturnTempValue(AdaptedProcedureSignature.returnType)(plan, worldPtrTemp)
    plan.steps += ps.Return(returnTempOpt)

    val irCommentOpt =
      for(targetProcLoc <- targetProcLocOpt;
          location <- targetProcLoc.locationOpt)
      yield
        s"Trampoline function for Scheme procedure defined at ${location.locationOnlyString}"

    PlannedFunction(
      signature=AdaptedProcedureSignature,
      namedArguments=List(
        ("world"   -> worldPtrTemp),
        ("closure" -> selfTemp),
        ("argList" -> argListHeadTemp)
      ),
      steps=plan.steps.toList,
      worldPtrOpt=Some(worldPtrTemp),
      debugContextOpt=None,
      irCommentOpt=irCommentOpt
    ) 
  }
}
