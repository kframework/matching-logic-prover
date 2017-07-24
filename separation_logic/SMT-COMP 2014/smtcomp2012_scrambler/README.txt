This is the official SMT-COMP 2011 benchmark scrambler for SMT-LIBv2 scripts. 

Its usage is as follows: 

Syntax: ./scrambler[options] < input_file.smt2
where options are:
  -terms_annot [true|false]
  -seed n (>= 0)
  -unfold PATTERN
  -unfold_start n
  -unfold_end n

-terms_annot true means that annotations associated to terms will be kept in
             the script, false means that they will be removed
-seed n is the random seed for scrambling. If not provided, the result of the
        time call is used. If the seed is 0, no scrambling is performed
-unfold PATTERN can be used to generate N individual benchmarks from an
                incremental one containing N (check-sat) commands. PATTERN in
                this case is a pattern for the output file names. For
                instance, with an input file containing 2 (check-sat)
                commands, -unfold OUT will generate OUT.1.smt2 and OUT.2.smt2
-unfold_start n and
-unfold_end n       can be used to unfold only a subrange of the indivdual
                    queries

Author: Alberto Griggio <griggio@fbk.eu>
License: MIT

Copyright (C) 2011 Alberto Griggio

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
