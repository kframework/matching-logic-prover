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
#include "scrambler.h"
#include <tr1/unordered_map>
#include <tr1/unordered_set>
#include <sstream>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <iostream>
#include <string.h>
#include <iomanip>
#include <fstream>
#include <algorithm>
#include <assert.h>
#include <ctype.h>


namespace scrambler {

namespace {

bool no_scramble = false;
bool scramble_named_annot = false;
bool lift_named_annot = false;

typedef std::tr1::unordered_map<std::string, std::string> NameMap;
NameMap names;

int name_idx = 1;

std::string make_name(int n)
{
    std::ostringstream tmp;
    tmp << "x" << n;
    return tmp.str();
}

std::vector<int> scopes;

std::vector<node *> commands;

uint64_t seed;
const uint64_t a = 25214903917ULL;
const uint64_t c = 11U;
const uint64_t mask = ~(2ULL << 48);

bool sort_commands = false;


const char *unquote(const char *n)
{
    if (no_scramble || !n[0] || n[0] != '|') {
        return n;
    }
    static std::string buf;
    buf = n;
    assert(!buf.empty());
    if (buf.size() > 1 && buf[0] == '|' && buf[buf.size()-1] == '|') {
        buf = buf.substr(1, buf.size()-2);
    }
    return buf.c_str();
}


size_t next_rand_int(size_t upper_bound)
{
    seed = ((seed * a) + c) & mask;
    return (size_t)(seed >> 16U) % upper_bound;
}

std::string get_name(const char *n)
{
    std::string sn(unquote(n));
    NameMap::iterator it = names.find(sn);
    if (it != names.end()) {
        return it->second;
    } else {
        return sn;
    }
}


int logic_dl = -1;
bool logic_is_dl()
{
    if (logic_dl == -1) {
        if (commands.size() > 0 && commands[0]->symbol == "set-logic") {
            std::string &logic = commands[0]->children[0]->symbol;
            logic_dl = (logic == "QF_IDL" ||
                        logic == "QF_RDL" ||
                        logic == "QF_UFIDL") ? 1 : 0;
        }
    }
    return logic_dl == 1;
}


} // namespace


void set_new_name(const char *n)
{
    n = unquote(n);
    if (no_scramble) {
        names[n] = n;
    } else {
        names[n] = make_name(name_idx++);
    }
}


void push_namespace()
{
    scopes.push_back(name_idx);
}


void pop_namespace()
{
    if (scopes.empty()) {
        std::cerr << "ERROR pop command over an empty stack" << std::endl;
        exit(1);
    }
    name_idx = scopes.back();
    scopes.pop_back();
}


void add_node(const char *s, node *n1, node *n2, node *n3, node *n4)
{
    node *ret = new node;
    ret->symbol = get_name(s);
    ret->needs_parens = true;
    if (n1) {
        ret->children.push_back(n1);
    }
    if (n2) {
        ret->children.push_back(n2);
    }
    if (n3) {
        ret->children.push_back(n3);
    }
    if (n4) {
        ret->children.push_back(n4);
    }

    commands.push_back(ret);
}


node *make_node(const char *s, node *n1, node *n2)
{
    node *ret = new node;
    ret->needs_parens = true;
    if (s) {
        ret->symbol = get_name(s);
    }
    if (n1) {
        ret->children.push_back(n1);
    }
    if (n2) {
        ret->children.push_back(n2);
    }
    if (!ret->symbol.empty() && ret->children.empty()) {
        ret->needs_parens = false;
    }
    return ret;
}


void del_node(node *n)
{
    for (size_t i = 0; i < n->children.size(); ++i) {
        del_node(n->children[i]);
    }
    delete n;
}


void node::add_children(std::vector<node *> *c)
{
    children.insert(children.end(), c->begin(), c->end());
}


node *make_node(std::vector<node *> *v)
{
    node *ret = new node;
    ret->needs_parens = true;
    ret->symbol = "";
    ret->children.assign(v->begin(), v->end());
    return ret;
}


node *make_node(node *n, std::vector<node *> *v)
{
    node *ret = new node;
    ret->needs_parens = true;
    ret->symbol = "";
    ret->children.push_back(n);
    ret->children.insert(ret->children.end(), v->begin(), v->end());
    return ret;
}


void set_seed(int s)
{
    seed = s;
}


void shuffle_list(std::vector<node *> *v, size_t start, size_t end)
{
    if (!no_scramble) {
        size_t n = end - start;
        for (size_t i = n-1; i > 0; --i) {
            std::swap((*v)[i+start], (*v)[next_rand_int(i+1)+start]);
        }
    }
}


void shuffle_list(std::vector<node *> *v)
{
    shuffle_list(v, 0, v->size());
}


bool is_commutative(node *n)
{
    std::string *curs = &(n->symbol);
    if (curs->empty() && !n->children.empty()) {
        curs = &(n->children[0]->symbol);
    }
    std::string &s = *curs;
    if (s == "and" || s == "or" || s == "xor" || s == "distinct") {
        return true;
    }
    if (!logic_is_dl()) {
        if (s == "*" || s == "+" || s == "=") {
            return true;
        }
        if (s == "bvand" || s == "bvor" || s == "bvxor" ||
            s == "bvnand" || s == "bvnor" || s == "bvcomp" ||
            s == "bvadd" || s == "bvmul") {
            return true;
        }
    }
    return false;
}


bool flip_antisymm(node *n, node **out_n)
{
    if (no_scramble) {
        return false;
    }
    
    if (!next_rand_int(2)) {
        return false;
    }
    
    std::string *curs = &(n->symbol);
    if (curs->empty() && !n->children.empty()) {
        curs = &(n->children[0]->symbol);
    }
    std::string &s = *curs;
    if (!logic_is_dl()) {
        if (s == "<") {
            *out_n = make_node(">");
            return true;
        } else if (s == ">") {
            *out_n = make_node("<");
            return true;
        } else if (s == "<=") {
            *out_n = make_node(">=");
            return true;
        } else if (s == ">=") {
            *out_n = make_node("<=");
            return true;
        } else if (s == "bvslt") {
            *out_n = make_node("bvsgt");
            return true;
        } else if (s == "bvsle") {
            *out_n = make_node("bvsge");
            return true;
        } else if (s == "bvult") {
            *out_n = make_node("bvugt");
            return true;
        } else if (s == "bvule") {
            *out_n = make_node("bvuge");
            return true;
        } else if (s == "bvsgt") {
            *out_n = make_node("bvslt");
            return true;
        } else if (s == "bvsge") {
            *out_n = make_node("bvsle");
            return true;
        } else if (s == "bvugt") {
            *out_n = make_node("bvult");
            return true;
        } else if (s == "bvuge") {
            *out_n = make_node("bvule");
            return true;
        }
    }
    return false;
}


namespace {

std::string make_annot_name(int n)
{
    std::ostringstream tmp;
    tmp << "y" << n;
    return tmp.str();
}

void set_named_annot(node *n)
{
    NameMap::iterator it = names.find(n->symbol);
    if (it != names.end()) {
        n->symbol = it->second;
    } else {
        std::string nn = make_annot_name(name_idx++);
        names[n->symbol] = nn;
        n->symbol = nn;
    }
}


bool is_named_annot(node *n, node **out=NULL)
{
    if (n->symbol == "!" && n->children.size() >= 2) {
        for (size_t j = 1; j < n->children.size(); ++j) {
            node *attr = n->children[j];
            if (attr->symbol == ":named" &&
                !attr->children.empty()) {
                if (out) {
                    *out = attr;
                }
                return true;
            }
        }
    }
    return false;
}


typedef std::tr1::unordered_set<std::string> StringSet;

std::string get_named_annot(node *root)
{
    std::vector<node *> to_process;
    std::tr1::unordered_set<node *> seen;

    to_process.push_back(root);
    while (!to_process.empty()) {
        node *cur = to_process.back();
        to_process.pop_back();

        if (!seen.insert(cur).second) {
            continue;
        }
        if (cur->symbol == "!") {
            if (cur->children.size() >= 1) {
                to_process.push_back(cur->children[0]);
            }
            if (cur->children.size() >= 2) {
                for (size_t j = 1; j < cur->children.size(); ++j) {
                    node *attr = cur->children[j];
                    if (attr->symbol == ":named" &&
                        !attr->children.empty()) {
                        return attr->children[0]->symbol;
                    }
                }
            }
        } else {
            for (size_t j = 0; j < cur->children.size(); ++j) {
                to_process.push_back(cur->children[j]);
            }
        }
    }

    return "";
}


void print_node(std::ostream &out, node *n, bool keep_annontations)
{
    if (!no_scramble && !keep_annontations && n->symbol == "!") {
        print_node(out, n->children[0], keep_annontations);
    } else {
        std::string name;
        if (lift_named_annot && keep_annontations) {
            node *annot = NULL;
            if (n->symbol == "assert") {
                name = get_named_annot(n);
                if (!name.empty()) {
                    if (scramble_named_annot) {
                        NameMap::iterator it = names.find(name);
                        if (it != names.end()) {
                            name = it->second;
                        } else {
                            std::string nn = make_annot_name(name_idx++);
                            names[name] = nn;
                            name = nn;
                        }
                    }
                }
            } else if (is_named_annot(n, &annot)) {
                if (n->children.size() == 2) {
                    n = n->children[0];
                } else {
                    n->children.erase(
                        std::find(n->children.begin(), n->children.end(),
                                  annot));
                    del_node(annot);
                }
            }
        }
        if (n->needs_parens) {
            out << '(';
        }
        if (!n->symbol.empty()) {
            out << n->symbol;
        }
        if (!name.empty()) {
            out << " (!";
        }
        if (scramble_named_annot && keep_annontations) {
            node *annot;
            if (is_named_annot(n, &annot)) {
                set_named_annot(annot->children[0]);
            }
        }
        for (size_t i = 0; i < n->children.size(); ++i) {
            if (i > 0 || !n->symbol.empty()) {
                out << ' ';
            }
            print_node(out, n->children[i], keep_annontations);
        }
        if (!name.empty()) {
            out << " :named " << name << ")";
        }
        if (n->needs_parens) {
            out << ')';
        }
    }
}


void print_command(std::ostream &out, node *n, bool keep_annontations)
{
    print_node(out, n, keep_annontations);
    out << std::endl;
}

std::tr1::unordered_map<std::string, int> sort_priorities;
void init_sort_priorities()
{
    sort_priorities["set-info"] = -1;
    sort_priorities["set-logic"] = 1;
    sort_priorities["declare-sort"] = 2;
    sort_priorities["define-sort"] = 3;
    sort_priorities["declare-fun"] = 4;
    sort_priorities["define-sort"] = 5;
    sort_priorities["define-fun"] = 6;
    sort_priorities["assert"] = 7;
    sort_priorities["check-sat"] = 8;
    sort_priorities["get-unsat-core"] = 9;
    sort_priorities["exit"] = 10;
}

bool commands_lt(node *a, node *b)
{
    if (a == b) {
        return false;
    }
    int pa = sort_priorities[a->symbol];
    int pb = sort_priorities[b->symbol];

    assert(pa != 0);
    assert(pb != 0);

    return pa < pb;
}

void sort_command_list()
{
    if (sort_commands) {
        init_sort_priorities();
        std::stable_sort(commands.begin(), commands.end(), commands_lt);
    }
}


void print_scrambled(std::ostream &out, bool keep_annotations)
{
    sort_command_list();
    
    // identify consecutive declarations and shuffle them
    for (size_t i = 0; i < commands.size(); ) {
        if (commands[i]->symbol == "declare-fun") {
            size_t j = i+1;
            while (j < commands.size() &&
                   commands[j]->symbol == "declare-fun") {
                ++j;
            }
            if (j - i > 1) {
                shuffle_list(&commands, i, j);
            }
            i = j;
        } else {
            ++i;
        }
    }

    // identify consecutive assertions and shuffle them
    for (size_t i = 0; i < commands.size(); ) {
        if (commands[i]->symbol == "assert") {
            size_t j = i+1;
            while (j < commands.size() && commands[j]->symbol == "assert"){
                ++j;
            }
            if (j - i > 1) {
                shuffle_list(&commands, i, j);
            }
            i = j;
        } else {
            ++i;
        }
    }    

    for (size_t i = 0; i < commands.size(); ++i) {
        print_command(out, commands[i], keep_annotations);
        del_node(commands[i]);
    }
    commands.clear();
}


void print_unfolded(const std::string &unfold_pattern, bool keep_annotations,
                    int unfold_start, int unfold_end)
{
    // unfold the incremental benchmark into a list of individual benchmarks
    size_t num_queries = 0;
    for (size_t i = 0; i < commands.size(); ++i) {
        if (commands[i]->symbol == "check-sat") {
            ++num_queries;
        }
    }
    std::cout << "Unfolding " << num_queries
              << " queries into individual scripts..." << std::endl;
    std::vector<int> idx;
    std::ostringstream tmpname;
    tmpname << num_queries;
    size_t w = tmpname.str().length();
    for (size_t i = 1; i <= num_queries; ++i) {
        if (unfold_start >= 0 && i < unfold_start) {
            continue;
        }
        if (unfold_end >= 0 && i > unfold_end) {
            continue;
        }
        
        idx.clear();
        tmpname.str("");
        tmpname << unfold_pattern << "."
                << std::setfill('0') << std::setw(w) << i << ".smt2";
        std::string fn = tmpname.str();

        // print out all the commands in the scope of the current query
        for (size_t j = 0, n = 0; j < commands.size(); ++j) {
            if (commands[j]->symbol == "check-sat") {
                ++n;
                if (n == i) {
                    idx.push_back(j);
                    std::ofstream out(fn.c_str());
                    for (size_t k = 0; k < idx.size(); ++k) {
                        if (idx[k] >= 0) {
                            print_command(out, commands[idx[k]],
                                          keep_annotations);
                        }
                    }
                    std::cout << "Written " << fn << std::endl;
                    break; // process next query
                }
            } else {                    
                if (commands[j]->symbol == "push") {
                    int howmany =
                        atoi(commands[j]->children[0]->symbol.c_str());
                    while (howmany-- > 0) {
                        idx.push_back(-1);
                    }
                } else if (commands[j]->symbol == "pop") {
                    int howmany =
                        atoi(commands[j]->children[0]->symbol.c_str());
                    while (howmany-- > 0) {
                        while (!idx.empty()) {
                            int n = idx.back();
                            idx.pop_back();
                            if (n == -1) {
                                break;
                            }
                        }
                    }
                } else {
                    idx.push_back(j);
                }
            }
        }
    }    
}


void usage(const char *program)
{
    std::cout << "Syntax: " << program << " [options] < input_file.smt2\n"
              << "where options are:\n"
              << "  -term_annot [true|false]\n"
              << "  -seed n (if 0, no scrambling is performed)\n"
              << "  -unfold PATTERN\n"
              << "  -unfold_start N\n"
              << "  -unfold_end N\n"
              << "  -core NAMES_FILE\n"
              << "  -scramble_named_annot [true|false]\n"
              << "  -lift_named_annot [true|false]\n";
    std::cout.flush();
    exit(1);
}


void filter_named(const StringSet &to_keep)
{
    size_t i, k;
    for (i = k = 0; i < commands.size(); ++i) {
        node *cur = commands[i];
        bool keep = true;
        if (cur->symbol == "assert") {
            std::string name = get_named_annot(cur);
            // if (!name.empty()) {
            //     std::cout << ";; found name: " << name << std::endl;
            // }
            if (!name.empty() && to_keep.find(name) == to_keep.end()) {
                // std::cout << ";;  removing name: " << name << std::endl;
                keep = false;
            }
        }
        if (keep) {
            commands[k++] = cur;
        }
    }
    commands.resize(k);
}


bool parse_names(std::istream &src, StringSet &out)
{
    std::string name;
    src >> name;
    if (!src || name != "unsat") {
        return false;
    }
    // skip chars until a '(' is found
    char c;
    while (src.get(c) && c != '(') {
        if (!isspace(c)) {
            return false;
        }
    }
    if (!src) {
        return false;
    }
    bool done = false;
    while (src && !done) {
        src >> name;
        if (name.empty()) {
            return false;
        }
        if (name[name.size()-1] == ')') {
            name = name.substr(0, name.size()-1);
            done = true;
        }
        if (!name.empty()) {
            out.insert(name);
        }
    }

    std::vector<std::string> outnames(out.begin(), out.end());
    std::sort(outnames.begin(), outnames.end());
    
    std::cout << ";; parsed " << outnames.size() << " names:";
    for (size_t i = 0; i < outnames.size(); ++i) {
        std::cout << " " << outnames[i];
    }
    std::cout << std::endl;

    return true;
}

} // namespace

} // namespace scrambler

char *c_strdup(const char *s)
{
    char *ret = (char *)malloc(strlen(s) + 1);
    strcpy(ret, s);
    return ret;
}


extern int yyparse();

using namespace scrambler;

int main(int argc, char **argv)
{
    bool keep_annotations = true;
    bool unfold = false;
    std::string unfold_pattern;
    int unfold_start = -1;
    int unfold_end = -1;
    bool create_core = false;
    std::string core_file;
    
    set_seed(time(0));

    for (int i = 1; i < argc; ) {
        if (strcmp(argv[i], "-seed") == 0 && i+1 < argc) {
            std::istringstream s(argv[i+1]);
            int x;
            if (s >> x && x >= 0) {
                if (x > 0) {
                    set_seed(x);
                } else {
                    no_scramble = true;
                }
            } else {
                std::cerr << "Invalid value for -seed: " << argv[i+1]
                          << std::endl;
                return 1;
            }
            i += 2;
        } else if (strcmp(argv[i], "-term_annot") == 0 && i+1 < argc) {
            if (strcmp(argv[i+1], "true") == 0) {
                keep_annotations = 1;
            } else if (strcmp(argv[i+1], "false") == 0) {
                keep_annotations = 0;
            } else {
                usage(argv[0]);
            }
            i += 2;
        } else if (strcmp(argv[i], "-unfold") == 0 && i+1 < argc) {
            unfold_pattern = argv[i+1];
            unfold = true;
            i += 2;
        } else if (strcmp(argv[i], "-unfold_start") == 0 && i+1 < argc) {
            std::istringstream s(argv[i+1]);
            int x;
            if (s >> x && x >= 0) {
                unfold_start = x;
            } else {
                usage(argv[0]);
            }
            i += 2;
        } else if (strcmp(argv[i], "-unfold_end") == 0 && i+1 < argc) {
            std::istringstream s(argv[i+1]);
            int x;
            if (s >> x && x >= 0) {
                unfold_end = x;
            } else {
                usage(argv[0]);
            }
            i += 2;
        } else if (strcmp(argv[i], "-sort") == 0) {
            sort_commands = true;
            ++i;
        } else if (strcmp(argv[i], "-core") == 0 && i+1 < argc) {
            create_core = true;
            core_file = argv[i+1];
            i += 2;
        } else if (strcmp(argv[i], "-scramble_named_annot") == 0 && i+1 < argc){
            if (strcmp(argv[i+1], "true") == 0) {
                scramble_named_annot = true;
            } else if (strcmp(argv[i+1], "false") == 0) {
                scramble_named_annot = false;
            } else {
                usage(argv[0]);
            }
            i += 2;
        } else if (strcmp(argv[i], "-lift_named_annot") == 0 && i+1 < argc) {
            if (strcmp(argv[i+1], "true") == 0) {
                lift_named_annot = true;
            } else if (strcmp(argv[i+1], "false") == 0) {
                lift_named_annot = false;
            } else {
                usage(argv[0]);
            }
            i += 2;            
        } else {
            usage(argv[0]);
        }
    }

    StringSet names;
    if (create_core) {
        std::ifstream src(core_file.c_str());
        if (!parse_names(src, names)) {
            std::cout << "ERROR in parsing core names from " << core_file
                      << std::endl;
            return 1;
        }
    }
    
    while (!std::cin.eof()) {
        yyparse();
        if (!unfold) {
            if (!commands.empty() && commands.back()->symbol == "check-sat") {
                if (create_core) {
                    filter_named(names);
                }
                print_scrambled(std::cout, keep_annotations);
            }
        }
    }

    if (create_core) {
        filter_named(names);
    }
    
    if (!unfold) {
        if (!commands.empty()) {
            print_scrambled(std::cout, keep_annotations);
        }
    } else {
        print_unfolded(unfold_pattern, keep_annotations,
                       unfold_start, unfold_end);
    }
    
    return 0;
}
