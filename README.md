# Evaluator-for-Integer-and-Symbolic-Expression
The idea in this program is to adopt a distributed memory viewpoint of the k-means algorithm https://en.wikipedia.org/wiki/K-means_clustering.

## Table of contents
* [General Information](#general-information)
* [Screenshots](#screenshots)
* [File Description](#file-description)
* [Usages](#usages)
* [Contact](#contact)

## General Information
K-means clustering is an important unsupervised learning algorithm. However, the sequential k-means algorithm is inefficient to cluster the large real-world data. Thus I wrote the parallel distributed version of the K-means algorithm to decrease the wall time required.

The algorithm has two important parts in each iteration after initialization: 1). Each process will perform local operations to obtain the the counter of clusters and summation of points of different clusters. MPI_All_Reduce was used to allow the communication between processors and add up the result. 2). Reset centroids using the result from 1) in root processor, and broadcast the new centroids to every processors.

## File Description
main.c is the main driver. 

The datasets used are US pollution data from 2016, which is available on umn cselab machine. Here, I only upload the very small datesets pollution_small.csv for testing. 

The auxil1.c contains a set of auxilliary functions, which includes the parallel dirstirbuted version of k-means algorithm. 

The python script solver.py is used to check the accuracy of the program.

## Screenshots
This is a demo running on phiXX.cselabs.umn.edu clusters.
```bash
mpirun -np 8 -hostfile hostfile -map-by node  main.ex
```
![Demo](./img/demo.png)

## Usages
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

1).Standard ML:
```bash
- expr_eval (fn _ => 5) (expr_add (expr_var "x") (expr_int 6));
val it = 11 : int
```
2).Scheme:
```bash
(expr-eval (lambda (v) 5) (expr-add (expr-var "x") (expr-int 6)))
;Value: 11
```

To evaluate the expression (expr_sub (expr_var "y") (expr_neg (expr_int 1))), where expr_var is assigned with the function if v = "x" then 3 else 5:

1).Standard ML:
```bash
- expr_eval (fn v => if v = "x" then 3 else 5) (expr_sub (expr_var "y") (expr_neg (expr_int 1)));
val it = 6 : int
```
2).Scheme:
```bash
(expr-eval (lambda (v) (if (string=? v "x") 3 5)) (expr-sub (expr-var "y") (expr-neg (expr-int 1))))
;Value: 6
```

To evaluate the expression (expr_mul (expr_var "x") (expr_neg (expr_mul (expr_var "y") (expr_var "z")))), where expr_var is assigned with the the function case v of "x" => 3 | "y" => 4 | _ => 5:

1).Standard ML:
```bash
- expr_eval (fn v => case v of "x" => 3 | "y" => 4 | _ => 5)  (expr_mul (expr_var "x") (expr_neg (expr_mul (expr_var "y") (expr_var "z"))));
val it = ~60 : int
```
2).Scheme:
```bash
(expr-eval (lambda (v) (cond ((string=? v "x") 3) ((string=? v "y") 4) (#t 5))) (expr-mul (expr-var "x") (expr-neg (expr-mul (expr-var "y") (expr-var "z")))))
;Value: -60
```

## Contact
Created by Buyun Liang [liang664@umn.edu] (https://www.linkedin.com/in/buyun-liang/) - feel free to contact me if you have any questions!
