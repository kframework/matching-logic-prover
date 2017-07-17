# A Survey of Separation Logic and Its Tools

[Rey02] *Separation Logic: A Logic for Shared Mutable Data Structures*

This paper proposes the idea of separation logic, an extension of Hoare logic that permits reasoning about low-level imperative programs that use shared mutable data strctures.It extends assertions by introducing "separation conjunction" and "separation implication",which, coupled with the inductive definition of predicates on abstract data structures, permit the concise and flexible description of structures with controlled sharing.This paper also surveys the current development of this program logic, including extensions that permit unrestricted address arithmetics, dynamically allocated arrays and recursive procedures. 

[CD11] *Infer: An Automatic Program Verifier for Memory Safety of C Programs*

This paper presents a tool called Infer, an automatic program verification tool aimed at proving memory safety of C programs. It builds a compositional proof of the program at hand by composing proofs of its constituent modules (functions / procedures). Its features includes: it's sound, scalable and completely automatic; it performs deep-heap analysis; it can analyze incomplete code. This paper uses the so called procedure-local bug to explain that Infer can automatically discover specs for the functions that can be proven to be memory safe. The tool is available as a command line tool, in the cloud, or as an Eclipse plug-in.

[DPV11] *Predator: A Practical Tool for Checking Manipulation of Dynamic Data Structures Using Separation Logic*

This paper presents a tool called Predator for fully automatic verification of sequential C programs with dynamic linked data structures (various complex kinds of singly-linked as well as doubly-linked lists in particular). Predator has a long-term goal of handling real system code, in particular, the Linux kernel. It is written in C++, built as a gcc plug-in, and open source. It comes with a limited support of pointer arithmetic. 
Along with the tool, a comprehensive set of programs (over a hundred test cases) that can be handled is distributed. Those include various textbook implementations of lists and examples using Linux lists at https://github.com/kdudka/predator/tree/61d5df3/sl/data. Those case studies are mid-size (up to 300 lines) but contain almost only pointer manipulations. What is also provided are examples of various sorting algorithms operating on various dynamic data structures. The tool is not proving the resulting lists are sorted but verifies memory safety of the code, which Invader is not able to do.

[Chl11] *Mostly-Automated Verification of Low-Level Programs in Computational Separation Logic*

This paper introduces a framework called Bedrock, which supports mostly-automated proofs about programs with the full range of features needed to implement. The key of its approach is in mostly-automated discharge of verification conditions inspired by separation logic. It can almost entirely avoid quantifiers, which are challenging in automated verifiers, by relying on functional programs, which leads to dramatic improvements compared to past work in classical verification and verified programming with code pointers. 

[JSPVPP11] *VeriFast: A Powerful, Sound, Predictable, Fast Verifier for C and Java*

[MQS12] *Recursive Proofs for Inductive Tree Data-Structures*

[QGSM13] *Natural Proofs for Structure, Data, and Separation*

[PMQ14] *Natural Proofs for Data Structure Manipulation in C using Separation Logic*

[AJP15] *Sound Modular Verification of C Code Executing in an Unverified Context*

This paper is based on the VeriFast verifier [JSPVPP11]. It develops runtime checks to be inserted at the boundary between the verified and the unverified part of a program to guarantee that no assertion failures or invalid memory accesses can occur at runtime in any verified module. The key part is transforming a verified module (with specification annotations) to a *hardened* module that consists of a functional part and a boundary checking part. Pure assertions, spatial assertions, predicates, inductive data types, and function pointers are taken into account. The authors formalize the approach in terms of a simple imperative programming language that models the C language, providing a comprehensive syntax and small-step semantics of the imperative language. Using that, the authors provide a formal correctness proof of those runtime checks. The tool is tested on some benchmark systems, including the insertion sorting algorithm on linked lists of integers, the in-order traversal algorithm on binary search trees, and some real world artifacts including Apache httpd authentication modules and NetKit FTP daemon. 

[JBR15] *Modular Termination Verification*

[BGKR16] *Model Checking for Symbolic-Heap Separation Logic with Inductive Predicates*

This paper investigates the model checking problem for symbolic-heap separation logic with user-defined inductive predicates. The problem is proved to be decidable and appreciates a bottom-up fixed point algorithm (instead of a top-down one). In general, the problem is EXPTIME-complete, but becomes NP-complete or PTIME-solvable when natural syntactic restrictions on the schemata defining the inductive predicates are assumed. This paper is a hard one. I haven't understood it yet. However, it has a good list of references.

[???] *Space Invader*

