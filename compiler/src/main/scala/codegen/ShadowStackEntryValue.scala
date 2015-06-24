package io.llambda.compiler.codegen
import io.llambda

import llambda.compiler.{celltype => ct}
import llambda.llvmir._

object ShadowStackEntryValue extends StructureValue("shadowStackEntry") {
  val nextField = StructureField(
    name="next",
    index=0,
    irType=PointerType(UserDefinedType("shadowStackEntry")),
    tbaaNode=NumberedMetadata(3)
  )

  val cellCountField = StructureField(
    name="cellCount",
    index=1,
    irType=IntegerType(32),
    tbaaNode=NumberedMetadata(4)
  )

  val rootsField = StructureField(
    name="roots",
    index=2,
    irType=ArrayType(0, PointerType(ct.AnyCell.irType)),
    tbaaNode=NumberedMetadata(5)
  )
  
  def genPointerToNext = genPointerToField(nextField)_
  def genLoadFromNext = genLoadFromField(nextField)_
  def genStoreToNext = genStoreToField(nextField)_
  
  def genPointerToCellCount = genPointerToField(cellCountField)_
  def genLoadFromCellCount = genLoadFromField(cellCountField)_
  def genStoreToCellCount = genStoreToField(cellCountField)_
  
  def genPointerToRoots = genPointerToField(rootsField)_
  def genLoadFromRoots = genLoadFromField(rootsField)_
  def genStoreToRoots = genStoreToField(rootsField)_
}
