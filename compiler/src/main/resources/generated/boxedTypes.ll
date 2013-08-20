;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This file is generated by gen-types.py. Do not edit manually. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; {unsigned typeId, unsigned gcState}
%boxedDatum = type {i16, i16}

; {supertype}
%unspecific = type {%boxedDatum}

; {supertype, car, cdr}
%pair = type {%boxedDatum, %boxedDatum*, %boxedDatum*}

; {supertype}
%emptyList = type {%boxedDatum}

; {supertype, unsigned byteLength, utf8Data}
%stringLike = type {%boxedDatum, i32, i8*}

; {supertype}
%string = type {%stringLike}

; {supertype}
%symbol = type {%stringLike}

; {supertype, value}
%boolean = type {%boxedDatum, i8}

; {supertype, signed value}
%exactInteger = type {%boxedDatum, i64}

; {supertype, value}
%inexactRational = type {%boxedDatum, double}

; {supertype, unsigned codePoint}
%character = type {%boxedDatum, i32}

; {supertype, unsigned length, data}
%byteVector = type {%boxedDatum, i32, i8*}

; {supertype, closure, entryPoint}
%procedure = type {%boxedDatum, %closure*, %boxedDatum* (%closure*, %boxedDatum*)*}

; {supertype, unsigned length, elements}
%vectorLike = type {%boxedDatum, i32, %boxedDatum**}

; {supertype}
%vector = type {%vectorLike}

; {supertype}
%closure = type {%vectorLike}
