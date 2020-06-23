For readability, the notes are listed from the latest to the oldest. 

# Meeting (2020/06/23)

Moving to LLVM:
  PR77: debugging about matching to do. 

Moving to AML:
  PR72 wip
  PR76 in review, should add SMT symbol definitions
  
Implementing ML proof system. 

# Meeting (2020/06/16)

Moving to LLVM:
  debugging

Moving to AML:
  PR73 merged. PR76 in review. 
  PR72 wip. 

Adding Notations:
  add "Head" syntax
  add notation declaration syntax
  add notatoin desugaring as a strategy
  add support for occurrences
  
# Meeting (2020/06/09)

Moving to LLVM:
  All four unit test modules have been merged to LLVM. We are merging the rest of the prover now. We expect this to be done in the next week. 
  
Moving to AML:
  Created PR73/PR76. Look at strategies/smt.md, remove built-in rules for `ML2SMTLIBDecls` and other fnuctions. First create a unit test. 
  Created PR72. 

# Meeting (2020/06/02)

We got stuck on the LLVM backend. Therefore, we plan to move to the task "moving to AML". The first task is to create a separation-of-concern between the reasoning modules (SMT and Pattern Matching) and the ML specifications that they work on. Thus, we identify the following two tasks to do in the week:
1. (JT, XC) Make SMT translation module be dependent only on the annotations about symbols (function and predicates).
2. (NR, LP) Make Pattern Matching module be dependent only on the annotations about assoc/comm/injectivity of functions. 

# Meeting (2020/05/27)

Items 2b and 2d have been finished. Item 2a is in progress (which is also the hardest one). Item 2c is not done yet but is expected to be simple.

Some refactoring notes
----------------------------

We should move the infrastructure from built-ins to pre-defined modules. In particular, the meta-level operations (such as free variables, substitution, etc) should have a fixed number of rules, and those definitions should not change as we develop the prover.


# Meeting (2020/05/26)

The Main Concerns
-----------------------

1. The current prover is going into different directions:
   1a. separation logic
   1b. hyper logic
   1c. Coq
   Some work is duplicated.

2. We need to allocate the work and split the tasks well.

3. Currently, the quantifier-free reasoning of the prover is weak and is done in an ad-hoc way, and thus making it less automatic. There are proof strategies that do not go bi-directional (e.g., phi -> psi1 \/ psi2 ===> phi -> psi1 or phi -> psi2). We have identified various forms of reasoning needed by the prover:
   3a. case analysis
   3b. \exists instantiation
   3c. recursion
   3d. frame reasoning
   However, it is not clear how to combine them properly. Ideas from DPLL?

4. We dislike the normalization strategies because it's adhoc and it's not general (only works well with FOLish fragments, does not normalize inside `mu`s or implication contexts ...), different parts of the prover rely on normalizations, it forces us to lose information we may later need to reconstruct (lifting conjunctions to the top. We need a systematic way of dealing with complex matching logic formulae. One possible way is to form a skeleton in some decidable logic to deal with many matching logic constructs, and then delegating to other sub-solvers to deal with other limited  fragments that may include quantifiers and use various fragment-specific heuristics.

5. The strategy language needs to be improved to allow more deterministic strategies. These deterministic strategies can be regarded as higher level proof objects. 

6. The prover should be moved to the LLVM backend.
  
7. We are not happy about the performance, including both the time to compile the prover (currently ~2min to compile the prover) and the running time of the prover. We are confident that the latter can be solved by moving to LLVM backend. We do not know how to solve the first one. One possible idea is to move more things from built-ins to inputs, so we do not need to compile the prover often. 

8. Adding support for notations.

9. Move to AML.

10. The display of proof trees should be improved for easy debugging. 


Current Short-Term Goal: Moving to LLVM backend.
------------------------------

Tasks
-----

1. Necessary refactoring on the unit tests module.
2. Move the following four modules:
   2a. SMT
   2b. Matching
   2c. Visitors
   2d. Substitution
3. Move the rest. 

Assignments
-----------

1. NR will do (1) on 05/26.
2. NR, JT, XC will hold a meeting on 05/27 and do one of the items under (2).
3. To be decided in the future.
