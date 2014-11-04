#ifndef _LLIBY_ALLOC_CELLREFTYPES_H
#define _LLIBY_ALLOC_CELLREFTYPES_H

/************************************************************
 * This file is generated by typegen. Do not edit manually. *
 ************************************************************/

#include "binding/AnyCell.h"
#include "alloc/StrongRef.h"

namespace lliby
{
namespace alloc
{

typedef StrongRef<AnyCell> AnyRef;
typedef StrongRefRange<AnyCell> AnyRefRange;
typedef StrongRef<UnitCell> UnitRef;
typedef StrongRefRange<UnitCell> UnitRefRange;
typedef StrongRef<ListElementCell> ListElementRef;
typedef StrongRefRange<ListElementCell> ListElementRefRange;
typedef StrongRef<PairCell> PairRef;
typedef StrongRefRange<PairCell> PairRefRange;
typedef StrongRef<EmptyListCell> EmptyListRef;
typedef StrongRefRange<EmptyListCell> EmptyListRefRange;
typedef StrongRef<StringCell> StringRef;
typedef StrongRefRange<StringCell> StringRefRange;
typedef StrongRef<InlineStringCell> InlineStringRef;
typedef StrongRefRange<InlineStringCell> InlineStringRefRange;
typedef StrongRef<HeapStringCell> HeapStringRef;
typedef StrongRefRange<HeapStringCell> HeapStringRefRange;
typedef StrongRef<SymbolCell> SymbolRef;
typedef StrongRefRange<SymbolCell> SymbolRefRange;
typedef StrongRef<InlineSymbolCell> InlineSymbolRef;
typedef StrongRefRange<InlineSymbolCell> InlineSymbolRefRange;
typedef StrongRef<HeapSymbolCell> HeapSymbolRef;
typedef StrongRefRange<HeapSymbolCell> HeapSymbolRefRange;
typedef StrongRef<BooleanCell> BooleanRef;
typedef StrongRefRange<BooleanCell> BooleanRefRange;
typedef StrongRef<NumberCell> NumberRef;
typedef StrongRefRange<NumberCell> NumberRefRange;
typedef StrongRef<ExactIntegerCell> ExactIntegerRef;
typedef StrongRefRange<ExactIntegerCell> ExactIntegerRefRange;
typedef StrongRef<FlonumCell> FlonumRef;
typedef StrongRefRange<FlonumCell> FlonumRefRange;
typedef StrongRef<CharCell> CharRef;
typedef StrongRefRange<CharCell> CharRefRange;
typedef StrongRef<VectorCell> VectorRef;
typedef StrongRefRange<VectorCell> VectorRefRange;
typedef StrongRef<BytevectorCell> BytevectorRef;
typedef StrongRefRange<BytevectorCell> BytevectorRefRange;
typedef StrongRef<RecordLikeCell> RecordLikeRef;
typedef StrongRefRange<RecordLikeCell> RecordLikeRefRange;
typedef StrongRef<ProcedureCell> ProcedureRef;
typedef StrongRefRange<ProcedureCell> ProcedureRefRange;
typedef StrongRef<RecordCell> RecordRef;
typedef StrongRefRange<RecordCell> RecordRefRange;
typedef StrongRef<ErrorObjectCell> ErrorObjectRef;
typedef StrongRefRange<ErrorObjectCell> ErrorObjectRefRange;
typedef StrongRef<PortCell> PortRef;
typedef StrongRefRange<PortCell> PortRefRange;
typedef StrongRef<EofObjectCell> EofObjectRef;
typedef StrongRefRange<EofObjectCell> EofObjectRefRange;
typedef StrongRef<DynamicStateCell> DynamicStateRef;
typedef StrongRefRange<DynamicStateCell> DynamicStateRefRange;

}
}

#endif
