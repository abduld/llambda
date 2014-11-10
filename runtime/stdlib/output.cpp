#include <iostream>
#include <cassert>

#include "binding/AnyCell.h"
#include "binding/PortCell.h"
#include "binding/StringCell.h"
#include "binding/BytevectorCell.h"

#include "writer/DisplayDatumWriter.h"

#include "unicode/UnicodeChar.h"
#include "unicode/utf8.h"

#include "port/AbstractPort.h"

#include "core/error.h"

#include "util/assertSliceValid.h"

using namespace lliby;

namespace
{
	std::ostream* portCellToOutputStream(World &world, PortCell *portCell)
	{
		AbstractPort *port = portCell->port();

		if (!port->isOutputPort())
		{
			signalError(world, "Attempted to write to non-output port", {portCell});
		}

		if (!port->isOutputPortOpen())
		{
			signalError(world, "Attempted to write to closed output port", {portCell});
		}

		return port->outputStream();
	}
}

extern "C"
{

void lliby_write(World &world, AnyCell *datum, PortCell *portCell)
{
	std::ostream *portStream = portCellToOutputStream(world, portCell);

	ExternalFormDatumWriter writer(*portStream);
	writer.render(datum);
}

void lliby_display(World &world, AnyCell *datum, PortCell *portCell)
{
	std::ostream *portStream = portCellToOutputStream(world, portCell);

	DisplayDatumWriter writer(*portStream);
	writer.render(datum);
}

void lliby_newline(World &world, PortCell *portCell)
{
	std::ostream *portStream = portCellToOutputStream(world, portCell);
	*portStream << std::endl;
}

void lliby_write_u8(World &world, std::uint8_t value, PortCell *portCell)
{
	std::ostream *portStream = portCellToOutputStream(world, portCell);
	*portStream << static_cast<char>(value);
}

void lliby_write_char(World &world, UnicodeChar character, PortCell *portCell)
{
	if (!character.isValid())
	{
		signalError(world, "(write-char) with invalid character");
	}

	std::vector<std::uint8_t> utf8Bytes(utf8::encodeChar(character));

	std::ostream *portStream = portCellToOutputStream(world, portCell);
	portStream->write(reinterpret_cast<char*>(utf8Bytes.data()), utf8Bytes.size());
}

void lliby_write_string(World &world, StringCell *stringCell, PortCell *portCell, std::uint32_t start, std::uint32_t end)
{
	assertSliceValid(world, "(write-string)", stringCell, stringCell->charLength(), start, end);

	StringCell::CharRange range = stringCell->charRange(start, end);
	assert(!range.isNull());

	// Write directly from the string's memory
	std::ostream *portStream = portCellToOutputStream(world, portCell);
	portStream->write(reinterpret_cast<const char *>(range.startPointer), range.endPointer - range.startPointer);
}

void lliby_write_bytevector(World &world, BytevectorCell *bytevectorCell, PortCell *portCell, std::uint32_t start, std::uint32_t end)
{
	assertSliceValid(world, "(write-bytevector)", bytevectorCell, bytevectorCell->length(), start, end);

	SharedByteArray *byteArray = bytevectorCell->byteArray();

	std::ostream *portStream = portCellToOutputStream(world, portCell);
	portStream->write(reinterpret_cast<const char *>(&byteArray->data()[start]), end - start);
}

void lliby_flush_output_port(World &world, PortCell *portCell)
{
	portCellToOutputStream(world, portCell)->flush();
}

}
