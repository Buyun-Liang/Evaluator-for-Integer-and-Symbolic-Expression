(* Define a type expr to represent integer expressions
* Such as integer literals, variables (represented as strings),
* negation, addition, subtraction, and multiplication.*)
datatype expr =   number of int
                | variable of string
                | neg of expr
                | add of expr * expr 
                | sub of expr * expr
                | mul of expr * expr;

  (* creates a new expression with number a *)
fun expr_int a = number a;

  (* creates a new expression with variable x  *)
fun expr_var x = variable x;

  (* creates a new expression representing `~ e` *)
fun expr_neg e = neg e;

  (* creates a new expression representing `e1 + e2`  *)
fun expr_add e1 e2 = add(e1, e2);

  (* creates a new expression representing `e1 - e2`  *)
fun expr_sub e1 e2 = sub(e1, e2);

  (* creates a new expression representing `e1 * e2`  *)
fun expr_mul e1 e2 = mul(e1, e2);

  (* `expr_eval env e` evaluates the expression `e`
   where `env "x"` gives the value of the variable `x` *)

   (* basic case: expression with only number *)
fun expr_eval env ( number a ) =   a 
  (* expression e is variable, apply env to obtain value  *)
  | expr_eval env (variable x) =  (env x)
  (* negation case  *)
  | expr_eval env ( neg e ) =
    let
        val num = expr_eval env  e
    in  (~num)
    end
  (* addition case  *)
  | expr_eval env ( add (e1, e2) ) = 
    let 
        val  num1 = expr_eval env e1
        val  num2 = expr_eval env e2 
    in
         (num1 + num2)
    end 
  (* substract case  *)  
  | expr_eval env ( sub (e1, e2) ) =
    let
        val  num1 = expr_eval env e1
        val  num2 = expr_eval env e2
    in
         (num1 - num2)
    end 
  (* multiplication case  *)  
  | expr_eval env ( mul (e1, e2) ) =
    let
        val  num1 = expr_eval env e1
        val  num2 = expr_eval env e2
    in
         (num1 * num2)
    end;


(*   Bonus Problem: expr_compile. *)
fun expr_compile (number a) = print( "x"^ Int.toString 0 ^ " = " ^ Int.toString a ^ ";\n" )
  | expr_compile (variable x) = print("x"^ Int.toString 0 ^ " = " ^ x ^ ";\n")
  | expr_compile (neg e) = 
    let      
        val _ = expr_compile(e)
    in
        print("x"^ Int.toString 0 ^ " = - x" ^ Int.toString 0^ ";\n"  )
    end
  | expr_compile (add (e1, e2) ) = 
    let
        val _ = expr_compile(e1)
        val _ = expr_compile(e2)
    in
        print("x"^ Int.toString 0 ^ " = " ^ "x" ^Int.toString 0 ^ " + x" ^ Int.toString 0^ ";\n"  )
    end
  | expr_compile (sub (e1, e2)) = 
    let
        val _ = expr_compile(e1)
        val _ = expr_compile(e2)
    in
        print("x"^ Int.toString 0 ^ " = " ^ "x" ^ Int.toString 0 ^ " - x" ^ Int.toString 0^ ";\n"  )
    end
  | expr_compile (mul (e1, e2) ) = 
    let    
        val _ = expr_compile(e1)
        val _ = expr_compile(e2)
    in
        print("x"^ Int.toString 0 ^ " = " ^ "x" ^Int.toString 0 ^ " * x" ^ Int.toString 0^ ";\n"  )
    end;

(*    
fun print_num index (number a) = 
  print( "x"^ Int.toString index ^ " = " ^Int.toString a ^ ";\n" );
  
fun print_var index (variable x) = 
  print("x"^ Int.toString index ^ " = " ^ x ^";\n");

fun print_neg index (neg e) index_1 =
    print("x"^ Int.toString index ^ " = " ^ "-x" ^Int.toString index_1 ^  ";\n"  );
    
fun print_op index (add(e1, e2)) index_1 index_2 = 
        print("x"^ Int.toString index ^ " = " ^ "x" ^Int.toString index_1 ^ " + x" ^ Int.toString index_2 ^ ";\n"  )
    | print_op index (sub(e1, e2)) index_1 index_2 =
        print("x"^ Int.toString index ^ " = " ^ "x" ^Int.toString index_1 ^ " - x" ^ Int.toString index_2 ^ ";\n"  )
    | print_op index (mul(e1, e2)) index_1 index_2 =
        print("x"^ Int.toString index ^ " = " ^ "x" ^Int.toString index_1 ^ " * x" ^ Int.toString index_2 ^ ";\n"  );

fun plus_one n = n + 1;
  *)
