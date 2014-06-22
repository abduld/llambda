(define-library (llambda typed)
	(import (llambda internal primitives))
    (import (llambda nfi))

    ; Re-export from (llambda primitives) 
    (export define-type ann define: define-record-type: lambda: make-predicate define-predicate U)

    (export <any> <list-element> <pair> <empty-list> <string> <symbol> <boolean> <number> <integer> <flonum> <char> <vector> <bytevector> <procedure>)
    (begin 
      (define-type <any> <datum-cell>)
      (define-type <list-element> <list-element-cell>)
      (define-type <pair> <pair-cell>)
      (define-type <empty-list> <empty-list-cell>)
      (define-type <string> <string-cell>)
      (define-type <symbol> <symbol-cell>)
      (define-type <boolean> <boolean-cell>)
      (define-type <number> <numeric-cell>)
      (define-type <integer> <exact-integer-cell>)
      (define-type <flonum> <inexact-rational-cell>)
      (define-type <char> <character-cell>)
      (define-type <vector> <vector-cell>)
      (define-type <bytevector> <bytevector-cell>)
      (define-type <procedure> <procedure-cell>)

      (define-syntax define-predicate
        (syntax-rules ()
                      ((define-predicate name type)
                       (define name (make-predicate type))))))
)
