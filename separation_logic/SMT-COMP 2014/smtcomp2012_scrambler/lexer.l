/* -*- fundamental -*-                                                        
 *                                                                            
 * Flex-based lexical scanner for the SMT-LIB v2 command language
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
#include <iostream>
#include <vector>
#include "parser.h"


#define YY_INPUT(buf,result,max_size) \
  { \
    size_t howmany = 0; \
    char *which = buf; \
    char c; \
    while (howmany < max_size && std::cin.get(c)) { \
        *which = c; \
        ++which; \
        ++howmany; \
        if (c == ')') break; \
    } \
    result = howmany ? howmany : YY_NULL; \
 }

%}
%option noyywrap
%option stack

%x START_STRING
%x START_QUOTEDSYMBOL
%option yylineno

BINCONSTANT         #b[0-1]+
HEXCONSTANT         #x[0-9a-fA-F]+
BVCONSTANT          bv[0-9]+
RATCONSTANT         [0-9]+\.[0-9]+
NUMERAL                    [0-9]+
SYMBOL              [a-zA-Z0-9._+\-*=%/?!$_~&^<>@]+
KEYWORD             :[a-zA-Z0-9._+\-*=%?!$_~&^<>@]+

%%
";"[^\n]*\n      { ; }
\n               { ; }
\r               { ; }
[ \t]            { ; }

"("              |
")"              { return yytext[0]; }

"as"             { return TK_AS; }
"_"              { return TK_UNDERSCORE; }
"let"            { return TK_LET; }
"!"              { return TK_BANG; }
"forall"         { return TK_FORALL; }
"exists"         { return TK_EXISTS; }

"set-logic"     { return TK_SET_LOGIC; }
"declare-sort"  { return TK_DECLARE_SORT; }
"define-sort"   { return TK_DEFINE_SORT; }
"declare-fun"   { return TK_DECLARE_FUN; }
"define-fun"    { return TK_DEFINE_FUN; }
"push"          { return TK_PUSH; }
"pop"           { return TK_POP; }
"assert"        { return TK_ASSERT; }
"check-sat"     { return TK_CHECK_SAT; }
"get-assertions" { return TK_GET_ASSERTIONS; }
"get-unsat-core" { return TK_GET_UNSAT_CORE; }
"get-proof"      { return TK_GET_PROOF; }
"set-option"     { return TK_SET_OPTION; }
"get-info"       { return TK_GET_INFO; }
"set-info"       { return TK_SET_INFO; }
"get-assignment" { return TK_GET_ASSIGNMENT; }
"get-model"      { return TK_GET_MODEL; }
"get-value"      { return TK_GET_VALUE; }
"exit"           { return TK_EXIT; }

{BINCONSTANT}  { yylval.string = c_strdup(yytext); return BINCONSTANT; }
{HEXCONSTANT}  { yylval.string = c_strdup(yytext); return HEXCONSTANT; }
{RATCONSTANT}  { yylval.string = c_strdup(yytext); return RATCONSTANT; }
{BVCONSTANT}   { yylval.string = c_strdup(yytext); return BVCONSTANT; }
{NUMERAL}      { yylval.string = c_strdup(yytext); return NUMERAL; }
{SYMBOL}       { yylval.string = c_strdup(yytext); return SYMBOL; }
{KEYWORD}      { yylval.string = c_strdup(yytext); return KEYWORD; }

\"              { yylval.buf = new std::vector<char>();
                  BEGIN(START_STRING); }
<START_STRING>{
  \\\"          { yylval.buf->push_back('"'); }
  [^\"\n]       { yylval.buf->push_back(yytext[0]); }
  \n            { yylval.buf->push_back('\n'); }
  \"            {
                  char *s;
                  yylval.buf->push_back('\0');
                  s = c_strdup(&(yylval.buf->front()));
                  delete yylval.buf;
                  yylval.buf = NULL;
                  yylval.string = s;
                  BEGIN(INITIAL); return STRING; }
}

\|              { yylval.buf = new std::vector<char>();
                  yylval.buf->push_back('|');
                  BEGIN(START_QUOTEDSYMBOL); }
<START_QUOTEDSYMBOL>{
  [^|]        { yylval.buf->push_back(yytext[0]); }
  \|          {
                char *s;
                yylval.buf->push_back('|');
                yylval.buf->push_back('\0');
                s = c_strdup(&(yylval.buf->front()));
                delete yylval.buf;
                yylval.buf = NULL;
                yylval.string = s;
                BEGIN(INITIAL); return SYMBOL; }
}

%%
