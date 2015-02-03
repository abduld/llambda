// This file is automatically generated by generate-error-categories.scm. Do not edit manually.

#include "binding/AnyCell.h"
#include "binding/ErrorObjectCell.h"
#include "binding/ErrorCategory.h"
#include "dynamic/SchemeException.h"

using namespace lliby;

namespace
{
	bool isErrorObjectOfCategory(AnyCell *obj, ErrorCategory expected)
	{
		if (auto errorObj = cell_cast<ErrorObjectCell>(obj))
		{
			return errorObj->category() == expected;
		}

		return false;
	}
}

extern "C"
{


void llerror_raise_file_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::File));
}

void llerror_raise_read_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::Read));
}

bool llerror_is_type_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::Type);
}

void llerror_raise_type_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::Type));
}

bool llerror_is_arity_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::Arity);
}

void llerror_raise_arity_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::Arity));
}

bool llerror_is_range_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::Range);
}

void llerror_raise_range_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::Range));
}

bool llerror_is_utf8_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::Utf8);
}

void llerror_raise_utf8_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::Utf8));
}

bool llerror_is_divide_by_zero_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::DivideByZero);
}

void llerror_raise_divide_by_zero_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::DivideByZero));
}

bool llerror_is_mutate_literal_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::MutateLiteral);
}

void llerror_raise_mutate_literal_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::MutateLiteral));
}

bool llerror_is_undefined_variable_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::UndefinedVariable);
}

void llerror_raise_undefined_variable_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::UndefinedVariable));
}

bool llerror_is_out_of_memory_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::OutOfMemory);
}

void llerror_raise_out_of_memory_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::OutOfMemory));
}

bool llerror_is_invalid_argument_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::InvalidArgument);
}

void llerror_raise_invalid_argument_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::InvalidArgument));
}

bool llerror_is_integer_overflow_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::IntegerOverflow);
}

void llerror_raise_integer_overflow_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::IntegerOverflow));
}

bool llerror_is_implementation_restriction_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::ImplementationRestriction);
}

void llerror_raise_implementation_restriction_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::ImplementationRestriction));
}

bool llerror_is_unclonable_value_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::UnclonableValue);
}

void llerror_raise_unclonable_value_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::UnclonableValue));
}

bool llerror_is_no_actor_error(AnyCell *obj)
{
	return isErrorObjectOfCategory(obj, ErrorCategory::NoActor);
}

void llerror_raise_no_actor_error(World &world, StringCell *message, RestValues<AnyCell> *irritants)
{
	throw dynamic::SchemeException(ErrorObjectCell::createInstance(world, message, irritants, ErrorCategory::NoActor));
}

}
