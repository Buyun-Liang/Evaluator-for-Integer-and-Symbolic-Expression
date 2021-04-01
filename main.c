#include <stdio.h>
#include <string.h>

struct expr;

const struct expr* expr_int(int);
const struct expr* expr_var(const char*);
const struct expr* expr_neg(const struct expr*);
const struct expr* expr_add(const struct expr*, const struct expr*);
const struct expr* expr_sub(const struct expr*, const struct expr*);
const struct expr* expr_mul(const struct expr*, const struct expr*);
int expr_eval(int (*)(const char*), const struct expr*);

/* this will include your source */
#include "expr.c"

int env1(const char* name) {
  return 5;
}

int env2(const char* name) {
  if (strcmp (name, "x") == 0) {
    return 3;
  } else {
    return 5;
  }
}

int env3(const char* name) {
  if (strcmp (name, "x") == 0) {
    return 3;
  } else if (strcmp (name, "y") == 0) {
    return 4;
  } else {
    return 5;
  }
}

void print_result(int i) { printf("%i\n", i); }

int main () {
  print_result(expr_eval(env1, expr_add(expr_var("x"), expr_int(6))));
  print_result(expr_eval(env2, expr_sub(expr_var("y"), expr_neg(expr_int(1)))));
  print_result(expr_eval(env3, expr_mul(expr_var("x"), expr_neg(expr_mul(expr_var("y"), expr_var("z"))))));
  return 0;
}
