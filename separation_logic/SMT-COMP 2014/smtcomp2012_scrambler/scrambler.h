/* -*- C++ -*-
 *
 * A simple scrambler for SMT-LIB v2 scripts
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
#ifndef SCRAMBLER_H_INCLUDED
#define SCRAMBLER_H_INCLUDED

#include <vector>
#include <string>

namespace scrambler {

struct node {
    std::string symbol;
    std::vector<node *> children;
    bool needs_parens;

    void add_children(std::vector<node *> *c);

    void set_parens_needed(bool b) { needs_parens = b; }
};


void set_new_name(const char *n);
void push_namespace();
void pop_namespace();

void add_node(const char *s,
              node *n1=NULL, node *n2=NULL, node *n3=NULL, node *n4=NULL);

node *make_node(const char *s=NULL, node *n1=NULL, node *n2=NULL);
node *make_node(std::vector<node *> *v);
node *make_node(node *n, std::vector<node *> *v);
void del_node(node *n);

void set_seed(int n);
void shuffle_list(std::vector<node *> *v);
bool is_commutative(node *n);
bool flip_antisymm(node *n, node **out_n);

} // namespace scrambler

char *c_strdup(const char *s);

#endif // SCRAMBLER_H_INCLUDED
