(define (helper curr num s)
    (if (and (not (null? s)) (= (car s) curr))
        (helper curr (+ num 1) (cdr-stream s))
    (list curr num)))

(define (next s curr)
    (if (null? s) s
    (if (= (car s) curr)
        (next (cdr-stream s) curr)
            s)))


(define (rle s)
    (if (null? s) nil
    (cons-stream (helper (car s) 0 s) (rle (next s (car s))))
))

;**************************************************************************

(define (helper2 curr s ans)
    (if (and (not (null? s)) (>= (car s) curr))
        (helper2 (car s) (cdr-stream s) (append ans (list (car s))))
        ans))

(define (next2 curr s)
    (if (null? s)
        nil
        (if (<= curr (car s)) (next2 (car s) (cdr-stream s)) s)))

(define (group-by-nondecreasing s)
    (if (null? s)
        nil
        (cons-stream (helper2 (car s) (cdr-stream s) (list (car s))) (group-by-nondecreasing (next2 (car s) s)))
    ))


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

