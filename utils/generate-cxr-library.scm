(import (scheme base))
(import (scheme write))

(define min-combo-length 3)
(define max-combo-length 4)

(define combos (let build-combos ([cur-list '()])
                 (define cur-length (length cur-list))
                 (if (> cur-length max-combo-length)
                   ; All done
                   '()
                   (append
                     (if (>= cur-length min-combo-length) (list cur-list) '())
                     (build-combos (cons #\a cur-list))
                     (build-combos (cons #\d cur-list))))))

(define (symbol-for-combo combo)
   (string->symbol (string-append "c" (list->string combo) "r")))

; Write our prefix
(display "; Generated by utils/generate-cxr-library.scm\n")
(display "(define-library (scheme cxr)\n")
(display "  (import (only (scheme base) car cdr define))\n")
(display "  (import (only (llambda typed) : <pair>))\n")

(display "  ")
(write (cons 'export (map symbol-for-combo combos)))
(newline)

(display "  (begin")

(for-each (lambda (combo)
            (define proc-symbol (symbol-for-combo combo))
            (define definition (let build-define ([remaining-combo combo])
                                 (if (null? remaining-combo)
                                   'x
                                   (if (char=? #\a (car remaining-combo))
                                     (list 'car (build-define (cdr remaining-combo)))
                                     (list 'cdr (build-define (cdr remaining-combo)))))))
            (newline)
            (display "    ")
            (write `(define ,`(,proc-symbol [x : <pair>]) ,definition)))
          combos)

(display "))\n")
