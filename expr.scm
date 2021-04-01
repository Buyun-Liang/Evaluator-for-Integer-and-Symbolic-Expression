; (expr-eval env E) evaluates the expression 'E'
; where env "x" gives the value of variable "x"
(define (expr-eval env E)

  ;basic case: expression with only number
  (cond ((constant? E) E )
	; expression E is variable, apply env to obtain value 
	((variable? E) (env E ) )
	; negation case
	((neg? E) ( - (expr-eval env (cdr E) )))
	; addition case
	((add? E) 
	 ( let* ( (num1 (expr-eval env ( car (cdr E) ))) 
		  (num2 (expr-eval env ( cdr (cdr E) ))) )
		(+ num1 num2)
		    ))
	; substract case
	((sub? E)
         ( let* ( (num1 (expr-eval env ( car (cdr E) )))
                  (num2 (expr-eval env ( cdr (cdr E) ))) )
                (- num1 num2)
                    ))
	; multiplication case
	((mul? E)
         ( let* ( (num1 (expr-eval env ( car (cdr E) )))
                  (num2 (expr-eval env ( cdr (cdr E) ))) )
                (* num1 num2)
                    ))
	
    )
  )

; Let constants be represented as numbers
(define constant? number?)

; Let variables be represented as strings
(define variable? string?)

; define function (expr-int a) to obtain constant a
(define (expr-int a) (if (constant? a) a) )

; define function (expr-var x) to obtain variable x
(define (expr-var x) (if (variable? x) x) )

; Predicate neg? returns true if its argument E
; is a pair with car 'negation
(define (neg? E)
  (and (pair? E) 
       (equal? 'negation (car E)) ))

; define function (expr-neg E) to obtain pair (negation . E)
(define (expr-neg E) (cons 'negation E))

; Predicate add? returns true if its argument E
; is a pair with car '+
(define (add? E)
  (and (pair? E)
       (equal? '+ (car E)) ))

; define function (expr-add E1 E2) to obtain pair (+ E1 . E 2)
(define (expr-add E1 E2) (cons '+ (cons E1 E2 ))  )

; Predicate sub? returns true if its argument E
; is a pair with car '-
(define (sub? E)
  (and (pair? E)
       (equal? '- (car E)) ))

; define function (expr-sub E1 E2) to obtain pair (- E1 . E 2)
(define (expr-sub E1 E2) (cons '- (cons E1 E2 ))  )

; Predicate mul? returns true if its argument E
; is a pair with car '*
(define (mul? E)
  (and (pair? E)
       (equal? '* (car E)) ))

; define function (expr-mul E1 E2) to obtain pair (* E1 . E 2)
(define (expr-mul E1 E2) (cons '* (cons E1 E2 ))  )
