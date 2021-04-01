#include <stdio.h>
#include <stdlib.h>

// Tag used to explicitly indicate which type is used
enum DataType {Number, Variable, Negation, Addition, Substraction, Multiplication };

// Tagged Union/ Variant 
struct expr {
	//Tag field
	enum DataType tag;
	// We are only supposed to use one of the elements
	// within a union, because all elements are stored
	// at the same spot
	// You have to use union types in struct expr to save space.
	union {
		// Number a, for expr_int
		struct {int a;} num;
		// Variable x, for expr_var
		struct {const char* x;} var;
		// Negative e, for expr_neg
		struct {
			const struct expr* e;
		} neg;
		// Addition e1, e2, for expr_add
		struct {
			const struct expr* e1;
			const struct expr* e2;	
		} add;
		// Substraction e1, e2, for expr_sub
		struct {
			const struct expr* e1;
			const struct expr* e2;
		} sub;
		// Multiplication e1, e2, for expr_mul
		struct {
				const struct expr* e1;
				const struct expr* e2;
		} mul;

	} fields;
};

const struct expr* expr_int(int a) {
	//Use malloc() to allocate the requested memory and return a pointer to expr
	struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));
	// Assign number
	ret_ptr -> fields.num.a = a;
	// Assign tag
	ret_ptr -> tag = Number;
	return ret_ptr;
};

const struct expr* expr_var(const char* x) {
	//Use malloc() to allocate the requested memory and return a pointer to expr
	struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));	
	// Assign variable
	ret_ptr -> fields.var.x = x;
	// Assign tag
	ret_ptr -> tag = Variable;
	return ret_ptr;
};

const struct expr* expr_neg(const struct expr* e1){
	//Use malloc() to allocate the requested memory and return a pointer to expr
	struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));
	// Assign expression
	ret_ptr -> fields.neg.e = e1;
	// Assign tag
	ret_ptr -> tag = Negation;
	return ret_ptr;
};

const struct expr* expr_add(const struct expr* e1, const struct expr* e2){
	//Use malloc() to allocate the requested memory and return a pointer to expr
    struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));
    // Assign expressions
	ret_ptr -> fields.add.e1 = e1;
	ret_ptr -> fields.add.e2 = e2;
	// Assign tag
	ret_ptr -> tag = Addition;
	return ret_ptr;
};

const struct expr* expr_sub(const struct expr* e1, const struct expr* e2){
	//Use malloc() to allocate the requested memory and return a pointer to expr
    struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));
    // Assign expressions
	ret_ptr -> fields.sub.e1 = e1;
    ret_ptr -> fields.sub.e2 = e2;
	// Assign tag
	ret_ptr -> tag = Substraction;
	return ret_ptr;
};

const struct expr* expr_mul(const struct expr* e1, const struct expr* e2){
	//Use malloc() to allocate the requested memory and return a pointer to expr
	struct expr* ret_ptr = (struct expr*) malloc(sizeof(struct expr));
	// Assign expressions
	ret_ptr -> fields.mul.e1 = e1;
	ret_ptr -> fields.mul.e2 = e2;
	// Assign tag
	ret_ptr -> tag = Multiplication;
	return ret_ptr;
};

int expr_eval(int (*env)(const char*), const struct expr* e) {

	int num = 0;
	// number case
	if (e -> tag == Number) {
		num = e -> fields.num.a;
	}

	// variable case
	//printf("Tag: %d\n", e -> tag);
	if (e -> tag == Variable) {
		num = env( e -> fields.var.x );
	}

	// negative case
	if (e -> tag == Negation) {
		num = -( expr_eval(env, e -> fields.neg.e));
        }	

	// addition case
	if (e -> tag == Addition) {
                num =  expr_eval(env, e -> fields.add.e1) + expr_eval(env, e -> fields.add.e2) ;
        }

	// substraction case
	if (e -> tag == Substraction) {
                num =  expr_eval(env, e -> fields.sub.e1) - expr_eval(env, e -> fields.sub.e2) ;
        }

	// multiplication case
	if (e -> tag == Multiplication) {
                num =  expr_eval(env, e -> fields.mul.e1) * expr_eval(env, e -> fields.mul.e2) ;
        }

	return num;

};

