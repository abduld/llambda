(cond-expand (immutable-pairs
  (define-test "(cons) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-1 (typed-dynamic 1 <exact-integer>))
    (define inexact-1 (typed-dynamic 1.0 <flonum>))

    (ann (cons exact-1 inexact-1) (Pairof <exact-integer> <flonum>))))

  (define-test "(car) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-1 (typed-dynamic 1 <exact-integer>))
    (define inexact-1 (typed-dynamic 1.0 <flonum>))

    (ann (car (cons exact-1 inexact-1)) <exact-integer>)))

  (define-test "(cdr) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-1 (typed-dynamic 1 <exact-integer>))
    (define inexact-1 (typed-dynamic 1.0 <flonum>))

    (ann (cdr (cons exact-1 inexact-1)) <flonum>)))

  (define-test "(list) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-1 (typed-dynamic 1 <exact-integer>))
    (define inexact-1 (typed-dynamic 1.0 <flonum>))

    (ann (list exact-1 inexact-1) (Listof <number>))))

  (define-test "(memv) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-list (typed-dynamic '(1 2 4) (Listof <exact-integer>)))
    (ann (memv 2 exact-list) (U #f (Listof <exact-integer>)))))

  (define-test "(member) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-list (typed-dynamic '(1 2 4) (Listof <exact-integer>)))
    (ann (member 2 exact-list) (U #f (Listof <exact-integer>)))))

  (define-test "(assv) is polymorphic" (expect-success
    (import (llambda typed))

    (define symbol-to-int (typed-dynamic '((one . 1) (two . 2) (four . 4)) (Listof (Pairof <symbol> <exact-integer>))))

    (ann (assv 'one symbol-to-int) (U #f (Pairof <symbol> <exact-integer>)))))

  (define-test "(list-tail) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-list (typed-dynamic '(1 2 4) (Listof <exact-integer>)))
    (ann (list-tail exact-list 1) (Listof <exact-integer>))))

  (define-test "(list-ref) is polymorphic" (expect-success
    (import (llambda typed))

    (define exact-list (typed-dynamic '(1 2 4) (Listof <exact-integer>)))
    (ann (list-ref exact-list 1) <exact-integer>)))

  (define-test "(reverse) is polymorphic" (expect-success
    (import (llambda typed))

    (define integer-list (typed-dynamic '(1 2 3) (Listof <exact-integer>)))
    (define reverse-list (reverse integer-list))

    (ann integer-list (Listof <exact-integer>))))

  (define-test "(map) is polymorphic" (expect-success
    (import (llambda typed))

    (define inexact-1 (typed-dynamic 1.0 <flonum>))
    (define integer-list (typed-dynamic '(1 2 3) (Listof <exact-integer>)))

    (ann (map (lambda (x) inexact-1) integer-list) (Listof <flonum>))))
  ))

(define-test "(+) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define exact-2 (typed-dynamic 1 <exact-integer>))

  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define inexact-2 (typed-dynamic 2.0 <flonum>))

  (ann (+ exact-1 exact-2) <exact-integer>)
  (ann (+ inexact-1 inexact-2) <flonum>)))

(define-test "(-) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define exact-2 (typed-dynamic 1 <exact-integer>))

  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define inexact-2 (typed-dynamic 2.0 <flonum>))

  (ann (- exact-1 exact-2) <exact-integer>)
  (ann (- inexact-1 inexact-2) <flonum>)))

(define-test "(*) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define exact-2 (typed-dynamic 1 <exact-integer>))

  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define inexact-2 (typed-dynamic 2.0 <flonum>))

  (ann (* exact-1 exact-2) <exact-integer>)
  (ann (* inexact-1 inexact-2) <flonum>)))

(define-test "(square) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define inexact-1 (typed-dynamic 1.0 <flonum>))

  (ann (square exact-1) <exact-integer>)
  (ann (square inexact-1) <flonum>)))

(define-test "(abs) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define inexact-1 (typed-dynamic 1.0 <flonum>))

  (ann (abs exact-1) <exact-integer>)
  (ann (abs inexact-1) <flonum>)))

(define-test "(min) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define exact-2 (typed-dynamic 1 <exact-integer>))

  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define inexact-2 (typed-dynamic 2.0 <flonum>))

  (ann (min exact-1 exact-2) <exact-integer>)
  (ann (min inexact-1 inexact-2) <flonum>)))

(define-test "(max) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define exact-2 (typed-dynamic 1 <exact-integer>))

  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define inexact-2 (typed-dynamic 2.0 <flonum>))

  (ann (max exact-1 exact-2) <exact-integer>)
  (ann (max inexact-1 inexact-2) <flonum>)))

(define-test "(vector-ref) is polymorphic" (expect-success
  (import (llambda typed))

  (define exact-1 (typed-dynamic 1 <exact-integer>))

  (ann (vector-ref #(1 2 3) exact-1) <exact-integer>)))

(define-test "simple polymorphic Scheme procedure" (expect-success
  (import (llambda typed))

  (: left-or-right (All (A) <boolean> A A A))
  (define (left-or-right use-left left-val right-val)
    (if use-left left-val right-val))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define inexact-1 (typed-dynamic 1.0 <flonum>))

  (ann (left-or-right dynamic-true exact-1 inexact-1) <number>)))

(define-test "polymorphic Scheme procedure violating return type variable fails" (expect-compile-failure
  (import (llambda typed))

  (: left-or-right (All (A) <boolean> A A A))
  (define (left-or-right use-left left-val right-val)
    'not-a-number)

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define inexact-1 (typed-dynamic 1.0 <flonum>))

  (left-or-right dynamic-true exact-1 inexact-1) <number>))

(define-test "violating Scheme procedure's type bounds fails" (expect-compile-failure
  (import (llambda typed))

  (: left-or-right (All ([A : <number>]) <boolean> A A A))
  (define (left-or-right use-left left-val right-val)
    (if use-left left-val right-val))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define string-val (typed-dynamic "Hello" <string>))

  (left-or-right dynamic-true exact-1 string-val)))

(define-test "capturing polymorphic Scheme procedure" (expect-success
  (import (llambda typed))

  (define outer-counter 0)

  (: inc-if-string (All (A) A <unit>))
  (define (inc-if-string possible-string)
    (when (string? possible-string)
      (set! outer-counter (+ outer-counter 1))))

  (define exact-1 (typed-dynamic 1 <exact-integer>))
  (define inexact-1 (typed-dynamic 1.0 <flonum>))
  (define string-val (typed-dynamic "Hello" <string>))

  (inc-if-string exact-1)
  (inc-if-string inexact-1)
  (inc-if-string string-val)

  (assert-equal 1 outer-counter)))

