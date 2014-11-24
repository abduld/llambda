; Generated by utils/generate-cxr-library.scm
(define-library (scheme cxr)
  (import (only (scheme base) car cdr define))
  (import (only (llambda typed) : <pair>))
  (export caaar caaaar cdaaar cdaar cadaar cddaar cadar caadar cdadar cddar caddar cdddar caadr caaadr cdaadr cdadr cadadr cddadr caddr caaddr cdaddr cdddr cadddr cddddr)
  (begin
    (define (caaar (x : <pair>)) (car (car (car x))))
    (define (caaaar (x : <pair>)) (car (car (car (car x)))))
    (define (cdaaar (x : <pair>)) (cdr (car (car (car x)))))
    (define (cdaar (x : <pair>)) (cdr (car (car x))))
    (define (cadaar (x : <pair>)) (car (cdr (car (car x)))))
    (define (cddaar (x : <pair>)) (cdr (cdr (car (car x)))))
    (define (cadar (x : <pair>)) (car (cdr (car x))))
    (define (caadar (x : <pair>)) (car (car (cdr (car x)))))
    (define (cdadar (x : <pair>)) (cdr (car (cdr (car x)))))
    (define (cddar (x : <pair>)) (cdr (cdr (car x))))
    (define (caddar (x : <pair>)) (car (cdr (cdr (car x)))))
    (define (cdddar (x : <pair>)) (cdr (cdr (cdr (car x)))))
    (define (caadr (x : <pair>)) (car (car (cdr x))))
    (define (caaadr (x : <pair>)) (car (car (car (cdr x)))))
    (define (cdaadr (x : <pair>)) (cdr (car (car (cdr x)))))
    (define (cdadr (x : <pair>)) (cdr (car (cdr x))))
    (define (cadadr (x : <pair>)) (car (cdr (car (cdr x)))))
    (define (cddadr (x : <pair>)) (cdr (cdr (car (cdr x)))))
    (define (caddr (x : <pair>)) (car (cdr (cdr x))))
    (define (caaddr (x : <pair>)) (car (car (cdr (cdr x)))))
    (define (cdaddr (x : <pair>)) (cdr (car (cdr (cdr x)))))
    (define (cdddr (x : <pair>)) (cdr (cdr (cdr x))))
    (define (cadddr (x : <pair>)) (car (cdr (cdr (cdr x)))))
    (define (cddddr (x : <pair>)) (cdr (cdr (cdr (cdr x)))))))
