#ifndef _LLIBY_ALLOC_ALLOCATOR_H
#define _LLIBY_ALLOC_ALLOCATOR_H

#include <stddef.h>

namespace lliby
{
namespace alloc
{

/**
 * Allocator for BoxedDatums
 */
void *allocateCons(size_t count = 1);
void preallocCons(size_t count);
void freeCons(void *);
	
}
}

#endif

