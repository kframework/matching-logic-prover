# A Survey of Separation Logic and Its Tools

### [Rey02] Separation Logic: A Logic for Shared Mutable Data Structures

  &nbsp;&nbsp;This paper proposes the idea of separation logic, an extension of Hoare logic that permits reasoning about low-level imperative programs that use shared mutable data strctures.It extends assertions by introducing "separation conjunction" and "separation implication",which, coupled with the inductive definition of predicates on abstract data structures, permit the concise and flexible description of structures with controlled sharing.This paper also surveys the current development of this program logic, including extensions that permit unrestricted address arithmetics, dynamically allocated arrays and recursive procedures. 
 
### [CD11] Infer: An Automatic Program Verifier for Memory Safety of C Programs

  &nbsp;&nbsp;This paper presents a tool called Infer, an automatic program verification tool aimed at proving memory safety of C programs. It builds a compositional proof of the program at hand by composing proofs of its constituent modules (functions / procedures). Its features includes: it's sound, scalable and completely automatic; it performs deep-heap analysis; it can analyze incomplete code. This paper uses the so called procedure-local bug to explain that Infer can automatically discover specs for the functions that can be proven to be memory safe. The tool is available as a command line tool, in the cloud, or as an Eclipse plug-in.

### [DPV11] Predator: A Practical Tool for Checking Manipulation of Dynamic Data Structures Using Separation Logic

  &nbsp;&nbsp;This paper presents a tool called Predator for fully automatic verification of sequential C programs with dynamic linked data structures (various complex kinds of singly-linked as well as doubly-linked lists in particular). Predator has a long-term goal of handling real system code, in particular, the Linux kernel. It is written in C++, built as a gcc plug-in, and open source. It comes with a limited support of pointer arithmetic. <br />
  &nbsp;&nbsp;Along with the tool, a comprehensive set of programs (over a hundred test cases) that can be handled is distributed. Those include various textbook implementations of lists and examples using Linux lists are [here](https://github.com/kdudka/predator/tree/61d5df3/sl/data). Those case studies are mid-size (up to 300 lines) but contain almost only pointer manipulations. What is also provided are examples of various sorting algorithms operating on various dynamic data structures. The tool is not proving the resulting lists are sorted but verifies memory safety of the code, which Invader is not able to do.

### [Chl11] Mostly-Automated Verification of Low-Level Programs in Computational Separation Logic

  &nbsp;&nbsp;http://adam.chlipala.net/bedrock/<br /> 
  &nbsp;&nbsp;This paper introduces a framework called Bedrock, which supports mostly-automated proofs about programs with the full range of features needed to implement. The key of its approach is in mostly-automated discharge of verification conditions inspired by separation logic. It can almost entirely avoid quantifiers, which are challenging in automated verifiers, by relying on functional programs, which leads to dramatic improvements compared to past work in classical verification and verified programming with code pointers. 

> * Tool&features:<br /> 
>  &nbsp;&nbsp;Bedrock. <br /> 
> &nbsp;&nbsp;Reason about first-class code pointers.Low-level.Avoid quantifiers.<br /> 
> * Verified programs/structures:<br /> 
>  &nbsp;&nbsp;The add function<br /> 
>  &nbsp;&nbsp;The swap function<br /> 
>  &nbsp;&nbsp;In-place list reverse<br /> 
> * Statics on case studies<br /> 
>  &nbsp;&nbsp;Module:    
>  &nbsp;&nbsp;Malloc &nbsp;&nbsp;Theory of arrays/lists &nbsp;&nbsp;ArrayList     &nbsp;&nbsp;Theory of sets   &nbsp;&nbsp;ThreadLib 
>  &nbsp;&nbsp;SinglyLinkedList  &nbsp;&nbsp;BinarySearchTree <br /> &nbsp;&nbsp;Theory of maps 
>  &nbsp;&nbsp;AssociationList     &nbsp;&nbsp;Hashtable    &nbsp;&nbsp;Memoize     &nbsp;&nbsp;AppendCPS   

### [JSPVPP11] VeriFast: A Powerful, Sound, Predictable, Fast Verifier for C and Java

&nbsp;&nbsp;https://people.cs.kuleuven.be/~bart.jacobs/verifast/<br /> 
&nbsp;&nbsp;This paper introduces a prototype verification tool Verifast for single-threaded and multithreaded C and Java programs.It first describes the basic symbolic execution approach in some formal detail. Then it zooms in on two technical aspects: the approach to permission accounting, including fractional permissions, precise predicates, and counting permissions; and the approach to lemma function termination in the presence of dynamically-bound lemma function calls.
> * Tool&features:<br /> 
>   &nbsp;&nbsp;VeriFast. <br /> 
>  &nbsp;&nbsp;C & Java.Single/multi-threaded.Support for permission accounting.<br /> 
> * Verified programs/structures:<br /> 
>   &nbsp;&nbsp;Symbolic execution algorithm<br /> 
>   &nbsp;&nbsp;Permission accounting<br /> 
>   &nbsp;&nbsp;JavaCard Programs<br /> 
>   &nbsp;&nbsp;Integrating Shape Analysis<br /> 
>   &nbsp;&nbsp;Linux Device Drivers<br /> 

### [BF11] Expressive Modular Fine-Grained Concurrency Specification

&nbsp;&nbsp;https://people.cs.kuleuven.be/~bart.jacobs/verifast/<br /> 
> * Tool&features:<br /> 
> &nbsp;&nbsp;VeriFast. <br /> 
>  &nbsp;&nbsp;Extend resource-invariants-based method to achieve procedure-modularity.Lift limitations on expressiveness of specifications.Enable fully general specification of fine-grained concurrent data structures.<br /> 
> * Verified programs/structures:<br /> 
> &nbsp;&nbsp;multiple-compare-and-swap algorithm (MCAS)<br /> 
> &nbsp;&nbsp; lock-couping list<br /> 
> * Statics<br /> 
> &nbsp;&nbsp;lcset.c | client.c | rdcss.c |mcas.c |client.c <br /> 
> &nbsp;&nbsp; 0.37s&nbsp;&nbsp;  |&nbsp;&nbsp;  0.13s &nbsp;  | &nbsp;&nbsp;  0.5s &nbsp;&nbsp; | &nbsp;1.33s &nbsp;|&nbsp; 0.22s  <br /> 


### [MQS12] Recursive Proofs for Inductive Tree Data-Structures

  &nbsp;&nbsp;http://www.cs.illinois.edu/∼madhu/dryad<br /> 
  &nbsp;&nbsp;This paper develops logical mechanisms and procedures to facilitate the verification of full functional properties of inductive tree data- structures using recursion that are sound, incomplete, but terminating.Its contribution rests in a new extension of first-order logic with recursive definitions called Dryad, a syntactical restriction on pre- and post-conditions of recursive imperative programs using Dryad, and a systematic methodology for accurately unfolding the footprint on the heap uncovered by the program that leads to finding simple recursive proofs using formula abstraction and calls to SMT solvers.  

> * Tool&features:<br /> 
> &nbsp;&nbsp;VCRYAD framework.<br /> 
> * Verified programs/structures:<br /> 
>  &nbsp;&nbsp; Sorted List &nbsp;&nbsp; &nbsp;&nbsp; Binary Heap  &nbsp;&nbsp; &nbsp;&nbsp;Treap  &nbsp;&nbsp; &nbsp;&nbsp;AVL Tree  &nbsp;&nbsp; &nbsp;&nbsp;Red-Black Tree &nbsp;&nbsp; &nbsp;&nbsp; B-Tree &nbsp;&nbsp; &nbsp;&nbsp; Binomial Heap <br /> 
> * Experimental results<br /> 
> &nbsp;&nbsp;On page 12<br /> 

### [QGSM13] Natural Proofs for Structure, Data, and Separation

  &nbsp;&nbsp;http://www.cs.uiuc.edu/∼madhu/dryad/sl/<br /> 
  &nbsp;&nbsp;This paper proposes natural proofs for reasoning with programs that manipulate data-structures against specifications that describe the structure of the heap, the data stored within it, and separation and framing of sub-structures. It develops Dryad and ways to reason with heaplets using classical logic over the theory of sets, and develop natural proofs for reasoning using proof tactics involving disciplined unfoldings and formula abstractions.It implement the technique and tested it on a large class of programs.<br /> 
> * Tool&features:<br /> 
> &nbsp;&nbsp;VCRYAD framework.<br /> 
> * Verified programs/structures:<br /> 
> &nbsp;&nbsp;Schorr-Waite algorithm for garbage collection<br /> 
> &nbsp;&nbsp;A large number of low-level C routines from the Glib library and OpenBSD library<br /> 
> &nbsp;&nbsp;The Linux kernel<br /> 
> &nbsp;&nbsp;Routines from a secure verified OS-browser project<br /> 
> * Experimental results<br /> 
> &nbsp;&nbsp;On page 10<br /> 

### [PMQ14] Natural Proofs for Data Structure Manipulation in C using Separation Logic

&nbsp;&nbsp;http://madhu.cs.illinois.edu/vcdryad/examples/<br /> 
&nbsp;&nbsp;http://madhu.cs.illinois.edu/vcdryad/<br /> 
&nbsp;&nbsp;This paper introduces a framework called VCDRYAD that extends the VCC framework to provide an automated deductive framework against separation logic specifications for C programs based on natural proofs. It develops several new techniques to build this framework, including a novel tool architecture that allows encoding natural proofs at a higher level in order to use the existing VCC framework (including its intricate memory model, the underlying type-checker, and the SMT-based verification infrastructure), and a synthesis of ghost-code annotations that captures natural proof tactics, in essence forcing VCC to find natural proofs using primarily decidable theories.<br />
> * Tool&features:<br /> 
>   &nbsp;&nbsp;VCRYAD framework. <br />
>    &nbsp;&nbsp;C programs.Lift Natural Proofs to the Code-Level<br /> 
> * Verified programs/structures:<br /> 
>   &nbsp;&nbsp;>150 data structures (singly-linked-list,sorted-list,doubly-linked-list,treap,avl...)<br /> 
>   &nbsp;&nbsp;Open source library routines (Glib, OpenBSD) <br /> 
    &nbsp;&nbsp;Linux kernel routines <br /> 
    &nbsp;&nbsp;Customized OS data structures<br /> 
> * Experimental results<br /> 
>   &nbsp;&nbsp;On page 10<br /> 

### [SL-COMP14]Report on SL-COMP 2014

&nbsp;&nbsp;https://github.com/mihasighi/smtcomp14-sl<br /> 
&nbsp;&nbsp;This report summarizes the Separation Logic Competition 2014, including its input theory, introduction to the participants and the benchmarks, competition results, conclusions and future work. The participating solvers are ASTERIX, CYCLIST-SL, SLEEK, SLIDE, SLSAT and SPEN. Their benchmarks can be found [here](https://github.com/mihasighi/smtcomp14-sl/tree/master/bench), which are organized in a common format designed like a logic of the SMT-LIB format. [Pre-processors](https://github.com/mihasighi/smtcomp14-sl/tree/master/pre-processors-sl) are used to for each solver to translate the common format problem into the internal format of each solver. The benchmarks are split into 5 divisions by the kind of problems solved and the kind of inductive definitions used. <br />
> &nbsp;&nbsp;sll(|=): includes satisfiability problems for the SLL fragment.<br />
> &nbsp;&nbsp;sll(=>): includes entailment problems for the SLL fragment and has the same source. <br />
> &nbsp;&nbsp;UDB(|=): includes satisfiability problems for the SLID+ fragment.<br />
> &nbsp;&nbsp;UDB(=>): includes entailment problems for formulas in the SLID+ fragment.<br />
> &nbsp;&nbsp;FDB(=>): includes entailment problems for formulas in the SLNL fragment.<br />
> * Benchmark features:<br /> 
> Total number of problems: <br /> 
> &nbsp;&nbsp;&nbsp;&nbsp;678 Satisfiability 25% Entailment 75%<br /> 
> Origin:<br /> 
> &nbsp;&nbsp;&nbsp;&nbsp;Crafted 41% Randomly generated 59%<br /> 
> Problems by division:<br /> 
> &nbsp;&nbsp;&nbsp;&nbsp;sll(|=) 110 &nbsp;&nbsp;sll(⇒) 292 &nbsp;&nbsp;FDB(⇒) 43 &nbsp;&nbsp;UDB(|=) 61 &nbsp;&nbsp;UDB(⇒) 172

* Participants:<br /> 
  &nbsp;&nbsp;ASTERIX: http://www.lsv.fr/~demri/NavarroPerezRybalchenko13.pdf<br />
> &nbsp;&nbsp;&nbsp;Asterix implements a model-based approach to decide separation logic satisfiability and entailment queries. Our procedure, relying on SMT solving technology to untangle potential aliasing between program variables, has at its core a _matching_ function that checks whether a concrete valuation is a model of the input formula and, if so, generalises it to a larger class of models where the formula is also valid. The version submitted to this competition is dynamically linked with Z3 and implements support for the acyclic list segment predicate only. Details about the algorithm and its correctness are described in J. A. Navarro Perez and A. Rybalchenko. Separation Logic Modulo Theories.

  &nbsp;&nbsp;&nbsp;&nbsp;CYCLIST-SL: https://github.com/ngorogiannis/cyclist<br />
> &nbsp;&nbsp;&nbsp;An entailment prover for separation logic with inductive predicates based on cyclic proof.  The theory and design is described in J. Brotherston, N. Gorogiannis, and R. L. Petersen. A generic cyclic theorem prover. In Proc. APLAS-10, pages 350-367. Springer, 2012.

&nbsp;&nbsp;&nbsp;&nbsp;SLEEK: http://loris-7.ddns.comp.nus.edu.sg/~project/s2/beta/<br /> 
> &nbsp;&nbsp;&nbsp;A solver deals with the satisfiability and entailment checking for SLID+ formulas. It is an (incomplete but) automatic prover, that builds a proof tree for the input problem by using the classical inference rules and the frame rule of SL. It also uses a database of lemmas for the inductive definitions in order to discharge the proof obligations on the spatial formulas. Provided by Quang Loc Le and Wei Ngan Chin.

&nbsp;&nbsp;&nbsp;&nbsp;SLIDE: http://www.fit.vutbr.cz/research/groups/verifit/tools/slide/<br /> 
> &nbsp;&nbsp;&nbsp;SLIDE is a tool for deciding entailments between two given predicates, from a larger system of inductively defined predicates, written in an existential fragment of Separation Logic. The proof method relies on converting both the left hand and right hand sides of the entailment into two tree automata AutLHS and AutRHS, respectively, and checking the tree language inclusion of the automaton AutLHS in the automaton AutRHS.

  &nbsp;&nbsp;&nbsp;&nbsp;SLSAT: http://www.dcs.bbk.ac.uk/~carsten/papers/CSLLICS14-slsat.pdf<br />
> &nbsp;&nbsp;&nbsp;A satisfiability checker for separation logic with inductive predicates. The algorithm, its soundness and its complexity are described in James Brotherston, Carsten Fuhs, Nikos Gorogiannis, and Juan Navarro Prez. A decision procedure for satisfiability in separation logic with inductive predicates. To appear at CSL-LICS, 2014.

&nbsp;&nbsp;&nbsp;&nbsp;SPEN: https://www.github.com/mihasighi/spen<br /> 
> &nbsp;&nbsp;&nbsp;An solver deals with satisfiability and entailment problems for the fragment SLNL. The decision pro- cedures calls the MiniSAT solver on a boolean abstraction of the SL formulas to check their satisfiability and to “normalize” the formulas by inferring its implicit (dis)equalities. Provided by Mihaela Sighireanu. 


### [AJP15] Sound Modular Verification of C Code Executing in an Unverified Context

  &nbsp;&nbsp;This paper is based on the VeriFast verifier [JSPVPP11]. It develops runtime checks to be inserted at the boundary between the verified and the unverified part of a program to guarantee that no assertion failures or invalid memory accesses can occur at runtime in any verified module. The key part is transforming a verified module (with specification annotations) to a *hardened* module that consists of a functional part and a boundary checking part. Pure assertions, spatial assertions, predicates, inductive data types, and function pointers are taken into account. The authors formalize the approach in terms of a simple imperative programming language that models the C language, providing a comprehensive syntax and small-step semantics of the imperative language. Using that, the authors provide a formal correctness proof of those runtime checks. The tool is tested on some benchmark systems, including the insertion sorting algorithm on linked lists of integers, the in-order traversal algorithm on binary search trees, and some real world artifacts including Apache httpd authentication modules and NetKit FTP daemon. 

### [JBK15] Modular Termination Verification

&nbsp;&nbsp;http://www.cs.kuleuven.be/~bartj/verifast/<br /> 
  &nbsp;&nbsp;This paper proposes an approach for the modular specification and verification of total correctness properties of object-oriented programs. It extends the existing program logic for partial correctness based on separation logic and abstract predicate families, with call permissions qualified by an arbitrary ordinal number, and it defines a specification style that properly hides implementation details, based on the ideas of using methods and bags of methods as ordinals, and exposing the bag of methods reachable from an object as an abstract predicate argument. The approach was illusitrated by several examples, including an example of transfering an amount of money between two bank accounts and an example of an interface method that takes as an argument another object.

### [RDF15] Iris: Monoids and invariants as an orthogonal basis for concurrent reasoning 

&nbsp;&nbsp;http://plv.mpi-sws.org/iris<br /> 
&nbsp;&nbsp;This paper presents Iris, a concurrent separation logic which only needs monoids and invariants. Partial commutative monoids enable us to express and invariants enable us to enforce— user-defined protocols on shared state, which are at the conceptual core of most recent program logics for concurrency. Furthermore, through a novel extension of the concept of a view shift, Iris supports the encoding of logically atomic specifications.<br />
> * Tool&features:<br /> 
> &nbsp;&nbsp;Iris logic.<br /> 
>  &nbsp;&nbsp;Only need monoids and invariants.<br /> 
> * Verified programs/structures:<br /> 
> &nbsp;&nbsp;A fine-grained elimination stack ADT<br /> 
> &nbsp;&nbsp;Hash Tables<br /> 

### [BGKR16] Model Checking for Symbolic-Heap Separation Logic with Inductive Predicates

  &nbsp;&nbsp;This paper investigates the model checking problem for symbolic-heap separation logic with user-defined inductive predicates. The problem is proved to be decidable and appreciates a bottom-up fixed point algorithm (instead of a top-down one). In general, the problem is EXPTIME-complete, but becomes NP-complete or PTIME-solvable when natural syntactic restrictions on the schemata defining the inductive predicates are assumed. This paper is a hard one. I haven't understood it yet. However, it has a good list of references.

### [Bar16] Partial Solutions to VerifyThis 2016 Challenges 2 and 3 with VeriFast

&nbsp;&nbsp;https://github.com/verifast/verifast<br /> 
&nbsp;&nbsp;This paper presents the partial solutions, using their VeriFast separation-logic based tool for modular formal verification of C and Java programs, to Challenges 2 and 3 of the VerifyThis 2016 Verification Competition, involving the verification of crash- freedom and certain correctness properties of code fragments implementing constant-space tree traversal and a tree barrier.<br />
> * Tool&features:<br /> 
>   &nbsp;&nbsp;VeriFast. <br />
>   &nbsp;&nbsp;C & Java.Symbolic execution.Single/multi-threaded.<br /> 
> * Verified programs/structures:<br /> 
>   Binary Tree Traversal<br /> 
>   &nbsp;&nbsp;&nbsp;&nbsp;  79 lines of annotations for 17LOC means an overhead of 5×.<br /> 
>   Static Tree Barriers<br /> 
>    &nbsp;&nbsp;&nbsp;&nbsp; 190 lines of annotations for 25LOC means an overhead of 8×.<br /> 

### Space Invader

&nbsp;&nbsp;http://www0.cs.ucl.ac.uk/staff/p.ohearn/Invader/Invader/Invader_Home.html <br /> 
&nbsp;&nbsp;http://www.cl.cam.ac.uk/~mjcg/SLandSI.pdf<br />

### Competitions<br /> 
* Separation Logic Competition 2014 <br /> 
&nbsp;&nbsp;https://www.irif.fr/~sighirea/slcomp/2014/index.html<br />
&nbsp;&nbsp; https://groups.google.com/forum/#!topic/sl-comp/tZLCevpNdmg<br /> 
* Separation Logic Competition 2015 <br />
&nbsp;&nbsp;https://www.irif.fr/~sighirea/slcomp/2015/index.html<br /> 
* VerifyThis Competition 2015 <br /> 
&nbsp;&nbsp;http://etaps2015.verifythis.org<br /> 
* VerifyThis Competition 2016 <br /> 
&nbsp;&nbsp;http://etaps2016.verifythis.org/home<br /> 
* VerifyThis Competition 2017 <br /> 
&nbsp;&nbsp;https://formal.iti.kit.edu/ulbrich/verifythis2017/<br /> 
