/* Facts and Rules for achieving Scheme lists operations in Prolog */ 
car([X|Y],X).
cdr([X|Y],Y).
caar([X|Y],Z) :- car(X,Z).
cdar([X|Y],Z) :- cdr(X,Z).
cadr([X|Y],Z) :- car(Y,Z).
caddr([X|Y],Z) :- cadr(Y,Z).
cadar([X|Y],Z) :- cadr(X,Z).
caddar([X|Y],Z) :- caddr(X,Z).

/* look up the variable X in the environmrnt ENV*/
 /* basic case: if [caar, ENV] is X */
lookup_env(X,ENV,V) :- caar(ENV,X), cdar(ENV,V).

/* case 2: continue to lookup_env for the remaining part of ENV */
lookup_env(X,ENV,V) :- cdr(ENV,ENV1), lookup_env(X, ENV1, V).

/* Use varibles X, values VAL, environment ENV, to form new enviroment */
/* Basic case: null variable */
put_env([],VAL,ENV,ENV). 

/* Case 1: form new ENV with variable X1 and value VAL1 */
put_env(X,VAL,ENV,ENV1) :- cdr(X,X1),cdr(VAL,VAL1), car(X,X2), car(VAL,VAL2), put_env(X1,VAL1,[[X2|VAL2]|ENV],ENV1).

/* Evaluating Expression E  with environment ENV
 * To obtain result V  */

 /* case 1 : if E is bound (i.e., not a variable) and is not compound
 *  Then use lookup_env to find the value of E  */
eval_with_env(E, ENV, V) :- atomic(E), lookup_env(E,ENV,V).

/* case 2: if first element in list E is quote  */
eval_with_env([quote|Y],ENV,V) :-  car(Y,V).

/* case 3: if first element in list E is car
 * find the first element of evaluation  */
eval_with_env([car|Y],ENV,V) :-  car(Y,Y1), eval_with_env(Y1,ENV,V1), car(V1 ,V).

/* case 4: if first element in list E is cdr
 * find the rest of the evaluation */
eval_with_env([cdr|Y],ENV,V) :-  car(Y,Y2), eval_with_env(Y2,ENV,V2), cdr(V2 ,V).

/* case 5: if first element in list E is cons
 * find the list formed with evalution of
 * first element and first element of remaining part*/
eval_with_env([cons|Y],ENV,V) :-  car(Y,Y1), cadr(Y,Y2), eval_with_env(Y1,ENV,V1), 
				eval_with_env(Y2,ENV,V2), V = [V1|V2].

/* case 6: if first element in list E is other symbol */
eval_with_env(E,ENV,V) :-  car(E,X), atomic(X), lookup_env(X,ENV,V1), cdr(E,V2), eval_with_eval([V1|V2], ENV,V).

/* case 7: if [caar, E] is lambda
 * form a new environment ENV1 with put_env
 * and evaluate aimed part [caddar,E] with ENV1  */
eval_with_env(E, ENV, V) :-  caar(E,lambda),caddar(E,E1), cadar(E,X), cdr(E,ES), 
				evlis(ES,ENV,VAL), put_env(X,VAL,ENV, ENV1), eval_with_env(E1, ENV1, V). 

/* basic case of evlis: empty list, no evaluation required  */
evlis([], ENV, []).

/* evaluate the first part of the list gets V1,
 * then evalute the later part obatin V2 
 * form a new list with two evaluation results */
evlis(ES, ENV, [V1|V2]) :-  car(ES, Y1), eval_with_env(Y1,ENV,V1), cdr(ES, ES1), evlis(ES1, ENV, V2). 
				
/* define a predicate eval with 2 arities  
such that eval(E,V) succeeds if and only if V is the result of evaluating E
Initializing env with empty-env [] */

eval(E,V) :- eval_with_env(E,[],V).
