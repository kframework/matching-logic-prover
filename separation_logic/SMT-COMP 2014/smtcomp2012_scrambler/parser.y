/* -*- C++ -*-
 *
 * Bison parser for the SMT-LIB v2 command language
 * 
 * Author: Alberto Griggio <griggio@fbk.eu>
 *
 * Copyright (C) 2011 Alberto Griggio
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

%{
#include "scrambler.h"
#include "parser.h"
#include "lexer.h"
#include <limits.h>
#include <assert.h>
#include <iostream>

#define YYMAXDEPTH LONG_MAX
#define YYLTYPE_IS_TRIVIAL 1

void yyerror(const char *s);

using namespace scrambler;

%}

%locations
%debug
%verbose
%defines "parser.h"

%union {
    char *string;
    std::vector<scrambler::node *> *nodelist;
    scrambler::node *curnode;
    std::vector<char> *buf;
};


%token_table

%token <string> BINCONSTANT
%token <string> HEXCONSTANT
%token <string> BVCONSTANT
%token <string> RATCONSTANT
%token <string> NUMERAL
%token <string> STRING
%token <string> SYMBOL
%token <string> KEYWORD
%token TK_EOF

%token TK_AS            "as"
%token TK_UNDERSCORE    "_"
%token TK_LET           "let"
%token TK_BANG          "!"
%token TK_FORALL        "forall"
%token TK_EXISTS        "exists"

%token TK_SET_LOGIC            "set-logic"
%token TK_DECLARE_SORT         "declare-sort"
%token TK_DEFINE_SORT          "define-sort"
%token TK_DECLARE_FUN          "declare-fun"
%token TK_DEFINE_FUN           "define-fun"
%token TK_PUSH                 "push"
%token TK_POP                  "pop"
%token TK_ASSERT               "assert"
%token TK_CHECK_SAT            "check-sat"
%token TK_GET_ASSERTIONS       "get-assertions"
%token TK_GET_UNSAT_CORE       "get-unsat-core"
%token TK_GET_PROOF            "get-proof"
%token TK_SET_OPTION           "set-option"
%token TK_GET_INFO             "get-info"
%token TK_SET_INFO             "set-info"
%token TK_GET_ASSIGNMENT       "get-assignment"
%token TK_GET_MODEL            "get-model"
%token TK_GET_VALUE            "get-value"
%token TK_EXIT                 "exit"

%type <curnode> logic_name
%type <curnode> a_sort
%type <curnode> a_sort_param
%type <curnode> a_term
%type <curnode> annotated_term
%type <curnode> plain_term
%type <curnode> term_num_constant
%type <nodelist> term_list

%type <nodelist> sort_list
%type <nodelist> sort_param_list
%type <nodelist> quant_var_list
%type <nodelist> let_bindings
%type <curnode> let_binding
%type <nodelist> num_list
%type <nodelist> int_list
%type <curnode> term_symbol
%type <curnode> term_unqualified_symbol
%type <string> info_argument

%type <curnode> term_attribute
%type <curnode> generic_sexp
%type <nodelist> generic_sexp_list
%type <nodelist> term_attribute_list

%destructor { free($$); } BINCONSTANT HEXCONSTANT RATCONSTANT NUMERAL SYMBOL KEYWORD STRING

%destructor { delete $$; } logic_name
%destructor { delete $$; } term_list
%destructor { delete $$; } sort_list
%destructor { delete $$; } sort_param_list
%destructor { delete $$; } quant_var_list
%destructor { delete $$; } num_list int_list
%destructor { delete $$; } term_symbol
%destructor { delete $$; } term_unqualified_symbol
%destructor { delete $$; } generic_sexp_list
%destructor { delete $$; } term_attribute_list

%start single_command

%%

single_command : command
  {
      YYACCEPT;
  }
;

command :
  cmd_set_logic
| cmd_declare_sort
| cmd_define_sort
| cmd_declare_fun
| cmd_define_fun
| cmd_push
| cmd_pop
| cmd_assert
| cmd_check_sat
| cmd_get_assertions
| cmd_get_unsat_core
| cmd_get_proof
| cmd_set_option
| cmd_get_info
| cmd_set_info
| cmd_get_assignment
| cmd_get_value
| cmd_exit
| cmd_error
;

cmd_error : 
  {
      YYERROR;
  }
;


cmd_set_logic : '(' TK_SET_LOGIC logic_name ')'
  {
      add_node("set-logic", $3);
  }
;


cmd_declare_sort : '(' TK_DECLARE_SORT SYMBOL NUMERAL ')'
  {
      set_new_name($3);
      add_node("declare-sort", make_node($3), make_node($4));
      free($4);
      free($3);
  }
;


cmd_define_sort :
  '(' TK_DEFINE_SORT SYMBOL '(' ')' a_sort ')'
  {
      set_new_name($3);
      add_node("define-sort", make_node($3), make_node(), $6);
      free($3);
  }
| '(' TK_DEFINE_SORT SYMBOL '(' sort_param_list ')' a_sort ')'
  {
      set_new_name($3);
      add_node("define-sort", make_node($3), make_node($5), $7);
      pop_namespace();
      free($3);
  }
;


cmd_declare_fun :
  '(' TK_DECLARE_FUN SYMBOL '(' ')' a_sort ')'
  {
      set_new_name($3);
      add_node("declare-fun", make_node($3), make_node(), $6);
      free($3);
  }
| '(' TK_DECLARE_FUN SYMBOL '(' sort_list ')' a_sort ')'
  {
      set_new_name($3);
      add_node("declare-fun", make_node($3), make_node($5), $7);
      free($3);
  }
;

cmd_define_fun :
  '(' TK_DEFINE_FUN SYMBOL '(' ')' a_sort a_term ')'
  {
      set_new_name($3);
      add_node("define-fun", make_node($3), make_node(), $6, $7);
      free($3);
  }
| '(' TK_DEFINE_FUN SYMBOL '(' quant_var_list ')' a_sort a_term ')'
  {
      set_new_name($3);
      add_node("define-fun", make_node($3), make_node($5), $7, $8);
      free($3);
  }
;


cmd_push : '(' TK_PUSH NUMERAL ')'
  {
      int n = atoi($3);
      for (int i = 0; i < n; ++i) {
          push_namespace();
      }
      add_node("push", make_node($3));
      free($3);
  }
;


cmd_pop : '(' TK_POP NUMERAL ')'
  {
      int n = atoi($3);
      for (int i = 0; i < n; ++i) {
          pop_namespace();
      }
      add_node("pop", make_node($3));
      free($3);
  }
;


cmd_assert :
  '(' TK_ASSERT a_term ')'
  {
      add_node("assert", $3);
  }
;


cmd_check_sat : '(' TK_CHECK_SAT ')'
  {
      add_node("check-sat");
  }
;


cmd_get_assertions : '(' TK_GET_ASSERTIONS ')'
  {
      add_node("get-assertions");
  }
;


cmd_get_unsat_core : '(' TK_GET_UNSAT_CORE ')'
  {
      add_node("get-unsat-core");
  }
;


cmd_get_proof : '(' TK_GET_PROOF ')'
  {
      add_node("get-proof");
  }
;


cmd_set_option :
  '(' TK_SET_OPTION KEYWORD NUMERAL ')'
  {
      add_node("set-option", make_node($3), make_node($4));
      free($4);
      free($3);
  }
| '(' TK_SET_OPTION KEYWORD RATCONSTANT ')'
  {
      add_node("set-option", make_node($3), make_node($4));
      free($4);
      free($3);
  }
| '(' TK_SET_OPTION KEYWORD SYMBOL ')'
  {
      add_node("set-option", make_node($3), make_node($4));
      free($4);
      free($3);
  }
| '(' TK_SET_OPTION KEYWORD STRING ')'
  {
      add_node("set-option", make_node($3), make_node($4));
      free($4);
      free($3);
  }
;


cmd_get_info : '(' TK_GET_INFO KEYWORD ')'
  {
      //add_node("get-info", make_node($3));
      free($3);
  }
;


cmd_set_info :
  '(' TK_SET_INFO KEYWORD info_argument ')'
  {
      //add_node("set-info", make_node($3), make_node($4));
      free($4);
      free($3);
  }
;


info_argument :
  NUMERAL
  {
      $$ = $1;
  }
| RATCONSTANT
  {
      $$ = $1;
  }
| SYMBOL
  {
      $$ = $1;
  }
| STRING
  {
      $$ = $1;
  }
;


cmd_get_assignment : '(' TK_GET_ASSIGNMENT ')'
  {
      add_node("get-assignment");
  }
;


cmd_get_value : '(' TK_GET_VALUE '(' term_list ')' ')'
  {
      add_node("get-value", make_node($4));
      delete $4;
  }
;


cmd_exit : '(' TK_EXIT ')'
  {
      add_node("exit");
  }
;


a_term :
  annotated_term
  {
      $$ = $1;
  }
| plain_term
  {
      $$ = $1;
  }
;


annotated_term :
  '(' TK_BANG a_term term_attribute_list ')'
  {
      $$ = make_node("!", $3);
      $$->add_children($4);
      delete $4;
  }
;


plain_term :
 '(' begin_let_scope '(' let_bindings ')' a_term ')'
  {
      shuffle_list($4);
      $$ = make_node("let", make_node($4), $6);
      delete $4;
      pop_namespace();
  }
| '(' TK_FORALL '(' quant_var_list ')' a_term ')'
  {
      shuffle_list($4);
      $$ = make_node("forall", make_node($4), $6);
      delete $4;
      pop_namespace();
  }
| '(' TK_EXISTS '(' quant_var_list ')' a_term ')'
  {
      shuffle_list($4);
      $$ = make_node("exists", make_node($4), $6);
      delete $4;
      pop_namespace();
  }
| term_num_constant
  {
      $$ = $1;
  }
| term_symbol
  {
      $$ = $1;
  }
| '(' term_symbol term_list ')'
  {
      node *n = $2;
      if (is_commutative($2)) {
          shuffle_list($3);
      } else if (flip_antisymm($2, &n)) {
          std::swap((*($3))[0], (*($3))[1]);
      }
      $$ = make_node(n, $3);
      if (n != $2) {
          del_node($2);
      }
      delete $3;
  }
;


term_symbol :
  term_unqualified_symbol
  { $$ = $1; }
| '(' TK_AS term_unqualified_symbol a_sort ')'
  {
      $$ = make_node("as", $3, $4);
  }
;


term_unqualified_symbol :
  SYMBOL
  {
      $$ = make_node($1);
      free($1);
  }
| '(' TK_UNDERSCORE SYMBOL num_list ')'
  {
      $$ = make_node("_", make_node($3));
      $$->add_children($4);
      free($3);
      delete $4;
  }
;


term_num_constant :
  NUMERAL
  {
      $$ = make_node($1);
      free($1);
  }
| RATCONSTANT
  {
      $$ = make_node($1);
      free($1);
  }
| BINCONSTANT
  {
      $$ = make_node($1);
      free($1);
  }
| HEXCONSTANT
  {
      $$ = make_node($1);
      free($1);
  }
| '(' TK_UNDERSCORE BVCONSTANT NUMERAL ')'
  {
      $$ = make_node("_", make_node($3), make_node($4));
      free($4);
      free($3);
  }
;


term_attribute_list :
  term_attribute
  {
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| term_attribute_list term_attribute
  {
      $$ = $1;
      $$->push_back($2);
  }
;


term_attribute :
  KEYWORD generic_sexp
  {
      $$ = make_node($1, $2);
      $$->set_parens_needed(false);
  }
;


generic_sexp :
  info_argument
  {
      $$ = make_node($1);
      free($1);
  }
| '(' ')'
  {
      $$ = make_node();
  }
| '(' generic_sexp_list ')'
  {
      $$ = make_node($2);
      delete $2;
  }
;

generic_sexp_list :
  generic_sexp
  {
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| generic_sexp_list generic_sexp
  {
      $$ = $1;
      $$->push_back($2);
  }
;


num_list :
  NUMERAL
  {
      $$ = new std::vector<node *>();
      $$->push_back(make_node($1));
      free($1);
  }
| num_list NUMERAL
  {
      $$ = $1;
      $$->push_back(make_node($2));
      free($2);
  }
;


int_list :
  NUMERAL
  {
      $$ = new std::vector<node *>();
      $$->push_back(make_node($1));
      free($1);
  }
| int_list NUMERAL
  {
      $$ = $1;
      $$->push_back(make_node($2));
      free($2);
  }
;


term_list :
  a_term
  {
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| term_list a_term
  {
      $1->push_back($2);
      $$ = $1;
  }
;


quant_var_list :
  '(' SYMBOL a_sort ')'
  {
      push_namespace();
      $$ = new std::vector<node *>();
      set_new_name($2);
      $$->push_back(make_node($2, $3));
      free($2);
  }
| quant_var_list '(' SYMBOL a_sort ')'
  {
      $$ = $1;
      set_new_name($3);
      $$->push_back(make_node($3, $4));
      free($3);
  }
;


begin_let_scope : TK_LET
  {
      push_namespace();
  }
;


let_bindings :
  let_binding
  {
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| let_bindings let_binding
  {
      $$ = $1;
      $$->push_back($2);
  }
;


let_binding : '(' SYMBOL a_term ')'
  {
      set_new_name($2);
      $$ = make_node($2, $3);
      free($2);
  }
;


logic_name : 
  SYMBOL
  {
      $$ = make_node($1);
      free($1);
  }
| SYMBOL '[' NUMERAL ']'
  {
      char *tmp = (char *)(malloc(strlen($1) + strlen($3) + 2 + 1));
      sprintf(tmp, "%s[%s]", $1, $3);
      $$ = make_node(tmp);
      free(tmp);
      free($1);
      free($3);
  }
;


sort_list :
  a_sort
  {
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| sort_list a_sort
  {
      $$ = $1;
      $$->push_back($2);
  }
;


a_sort : 
  SYMBOL
  {
      $$ = make_node($1);
      free($1);
  }
| '(' TK_UNDERSCORE SYMBOL int_list ')'
  {
      $$ = make_node("_", make_node($3));
      $$->add_children($4);
      delete $4;
      free($3);
  }
| '(' SYMBOL sort_list ')'
  {
      $$ = make_node($2);
      $$->add_children($3);
      $$->set_parens_needed(true);
      delete $3;
      free($2);
  }
;


sort_param_list : 
  a_sort_param
  {
      push_namespace();
      $$ = new std::vector<node *>();
      $$->push_back($1);
  }
| sort_param_list a_sort_param
  {
      $$ = $1;
      $$->push_back($2);
  }
;


a_sort_param : SYMBOL
  {
      set_new_name($1);
      $$ = make_node($1);
      free($1);
  }
;


%%

void yyerror(const char *s)
{
    std::cerr << "ERROR: " << s << std::endl;
    exit(1);
}
