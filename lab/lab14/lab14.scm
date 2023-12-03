(define (split-at lst n)
	(define (helper head tail n)
	(if (null? tail)
		(cons head nil)
		(if ( = 0 n)
			(cons head tail)
			(helper (append head (list (car tail))) (cdr tail) (- n 1)))))
	(helper nil lst n))




(define-macro (switch expr cases)
	(cons _________
		(map (_________ (_________) (cons _________ (cdr case)))
    			cases))
)

