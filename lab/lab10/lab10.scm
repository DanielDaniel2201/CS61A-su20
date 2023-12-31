(define (over-or-under num1 num2)
  (cond
    ((> num1 num2) '1)
    ((< num1 num2) '-1)
    (else '0)
))

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (filter-lst fn lst)
  (cond
    ((null? lst)
      nil)
    ((fn (car lst))
      (cons (car lst) (filter-lst fn (cdr lst) )))
    (else
      (filter-lst fn (cdr lst) ))
  ))

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (make-adder num)
  (define (add x)
    (+ x num))
  add
  )

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define lst
  (cons '(1) (cons 2 (cons (cons 3 (cons 4 nil)) (cons 5 nil))))
)


(define (composed f g)
  (define (helper x)
    (f (g x)))
  helper
)


(define (remove item lst)
  (cond
    ((null? lst)
      nil)
    ((= item (car lst))
      (remove item (cdr lst) ))
    (else
      (cons (car lst) (remove item (cdr lst) )))
))


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)


(define (no-repeats s)
  (if (null? s)
    nil
    (cons (car s) (no-repeats(remove (car s) (cdr s)))))
)


(define (substitute s old new)
  (cond
    ((null? s) nil)
    ((eq? (car s) old) (cons new (substitute (cdr s) old new)))
    ((pair? (car s)) (cons (substitute (car s) old new) (substitute (cdr s) old new)))
    (else (cons (car s) (substitute (cdr s) old new)))
))


(define (sub-all s olds news)
  (cond
    ((null? s) nil)
    ((null? olds) s)
    (else
      (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news)))
))
