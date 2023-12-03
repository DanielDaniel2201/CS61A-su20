(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond
    ((> num 0) 1)
    ((< num 0) -1)
    (else 0))
)


(define (square x) (* x x))

(define (pow x y)
  (cond
    ((= y 1) x)
    ((even? y) (square (pow x (/ y 2))))
    (else
      (* x (square (pow x (/ (- y 1) 2)))))
))


(define (unique s)
  (if (null? s)
    nil
    (cons (car s) (unique (filter (lambda (x) (not (eq? x (car s)))) (cdr s))))
))


(define (replicate x n)
  (define (rep-sofar x n s-sofar)
    (if (= n 0)
      s-sofar
      (rep-sofar x (- n 1)
        (cons x s-sofar))))
    (rep-sofar x n nil)
  )


(define (accumulate combiner start n term)
  (define (accumulate-helper combiner start n term sofar i)
    (if (= n 0)
      sofar
      (accumulate-helper combiner start (- n 1) term (combiner sofar (term (+ i 1))) (+ i 1))))
  (accumulate-helper combiner start n term start 0)
)


(define (accumulate-tail combiner start n term)
  (define (accumulate-helper combiner start n term sofar i)
    (if (= n 0)
      sofar
      (accumulate-helper combiner start (- n 1) term (combiner sofar (term (+ i 1))) (+ i 1))))
  (accumulate-helper combiner start n term start 0)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)

