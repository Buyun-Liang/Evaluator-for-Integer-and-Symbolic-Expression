# Evaluator-for-Integer-and-Symbolic-Expression
The main goal of this project includes:
1) Developing evaluators in SML, Scheme and C to evaluate integer expressions built from integer literals, variables (represented as strings), negation, addition, subtraction, and multiplication.

2) Implementing a mini-Prolog evaluator to handle the encoding of S-expressions from Scheme

## Table of contents
* [File Description](#file-description)
* [Usages of Integer Expression Evaluator](#usages-of-integer-expression-evaluator)
* [Usages of Symbolic Expression Evaluator](#usages-of-symbolic-expression-evaluator)
* [Contact](#contact)


## File Description


The SML program expr.sml defines a type expr to represent integer expressions. 

The Scheme program expr.scm defines functions expr-int, expr-var, expr-neg, expr-add, expr-sub, expr-mul, and expr-eval in a similar way. 

The C program expr.c uses union types and pointers to define a structure type struct expr to represent integer expressions.

main.c is the main driver for the c program. 

The Prolog program pexp.pl could evaluate the encoding of S-expressions.
 

## Usages of Integer Expression Evaluator

Standard ML:
```bash
rlwrap sml expr.sml
```
Scheme:
```bash
module load scheme/mit-gnu
rlwrap mit-scheme --load  expr.scm
```


To evaluate the expression (expr_add (expr_var "x") (expr_int 6)), where expr_var is assigned with the number 5:

1) Standard ML:
```bash
- expr_eval (fn _ => 5) (expr_add (expr_var "x") (expr_int 6));
val it = 11 : int
```
2) Scheme:
```bash
(expr-eval (lambda (v) 5) (expr-add (expr-var "x") (expr-int 6)))
;Value: 11
```

To evaluate the expression (expr_sub (expr_var "y") (expr_neg (expr_int 1))), where expr_var is assigned with the function if v = "x" then 3 else 5:

1) Standard ML:
```bash
- expr_eval (fn v => if v = "x" then 3 else 5) (expr_sub (expr_var "y") (expr_neg (expr_int 1)));
val it = 6 : int
```
2) Scheme:
```bash
(expr-eval (lambda (v) (if (string=? v "x") 3 5)) (expr-sub (expr-var "y") (expr-neg (expr-int 1))))
;Value: 6
```

To evaluate the expression (expr_mul (expr_var "x") (expr_neg (expr_mul (expr_var "y") (expr_var "z")))), where expr_var is assigned with the the function case v of "x" => 3 | "y" => 4 | _ => 5:

1) Standard ML:
```bash
- expr_eval (fn v => case v of "x" => 3 | "y" => 4 | _ => 5)  (expr_mul (expr_var "x") (expr_neg (expr_mul (expr_var "y") (expr_var "z"))));
val it = ~60 : int
```
2) Scheme:
```bash
(expr-eval (lambda (v) (cond ((string=? v "x") 3) ((string=? v "y") 4) (#t 5))) (expr-mul (expr-var "x") (expr-neg (expr-mul (expr-var "y") (expr-var "z")))))
;Value: -60
```

Results of C: 
```bash
gcc main.c 
./a.out 
11
6
-60
```

## Usages of Symbolic Expression Evaluator

Prolog:
```bash
rlwrap swipl pexp.pl
```
The S-expression (car (cdr (cdr (quote (x y z))))) is encoded as [car,[cdr,[cdr,[quote,[x,y,z]]]]]. To evaluate it, run
```bash
eval([car,[cdr,[cdr,[quote,[x,y,z]]]]],z).
true .
```

## Contact
Created by Buyun Liang [liang664@umn.edu] (https://www.linkedin.com/in/buyun-liang/) - feel free to contact me if you have any questions!
