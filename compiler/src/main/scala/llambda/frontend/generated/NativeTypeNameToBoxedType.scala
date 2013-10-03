/*****************************************************************
 * This file is generated by gen-types.py. Do not edit manually. *
 *****************************************************************/

package llambda.frontend

import llambda.codegen.{boxedtype => bt}

object NativeTypeNameToBoxedType {
  def apply : PartialFunction[String, bt.BoxedType] = {
    case "boxed-datum" => bt.BoxedDatum
    case "boxed-unspecific" => bt.BoxedUnspecific
    case "boxed-list-element" => bt.BoxedListElement
    case "boxed-pair" => bt.BoxedPair
    case "boxed-empty-list" => bt.BoxedEmptyList
    case "boxed-string-like" => bt.BoxedStringLike
    case "boxed-string" => bt.BoxedString
    case "boxed-symbol" => bt.BoxedSymbol
    case "boxed-boolean" => bt.BoxedBoolean
    case "boxed-numeric" => bt.BoxedNumeric
    case "boxed-exact-integer" => bt.BoxedExactInteger
    case "boxed-inexact-rational" => bt.BoxedInexactRational
    case "boxed-character" => bt.BoxedCharacter
    case "boxed-byte-vector" => bt.BoxedByteVector
    case "boxed-procedure" => bt.BoxedProcedure
    case "boxed-vector-like" => bt.BoxedVectorLike
    case "boxed-vector" => bt.BoxedVector
  }
}
