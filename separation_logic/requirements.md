#Requirements <br />
##Concepts

The mlprover is an interactive system in which the users can develop a formal proof of a collection of obligations via an interface called the tactic language.
An obligation contains a hypothetic theory and a pattern-to-prove. 

##List of tactics

1)	Universal quantifier elimination. No argument or one argument specifying which quantified variable to eliminate. When it is called, a constant is introduced for the variable in domain.

2)	Existential quantifier elimination. No argument or one argument specifying which quantified variable to eliminate. (Is it sound?)

3)	Conjunction split. Split a conjunction into several subgoals and give them labels for distinguishing.

4)	Orientation of equational axioms. Substitute a certain structure in the goal which matches the left side of some axiom for the right side of it. Several arguments to specify which structure and which axiom to apply. (See point 10)13.)

5)	Frame rule. From P1 -> P2, deduce sigma(Q1,...P1,...Qn) -> sigma(Q1,...P2,...Qn). 

6)	Constraint propagation. The pattern to be propagated must be a predicate pattern. Two arguments to decide which pattern to propagate and propagate to which place. 

7)	Definedness symbols treatment. Eliminate floor() and top(). (How does it work?)

8)	Case analysis.

9)	Magic wand (separating implication). When it is used, it’s then immediately changed to the specified structure automatically. (I don’t think we need this. This is too specific to SL. Either we need a generic approach to deal with syntactic sugars, or we simply ignore them for now. I think we should adopt the second, since we already have a lot to consider at present. Given that said, we will need all common syntactic sugar about connectives, such as disjunction, implication, existential quantification, flooring and ceiling, top and bottom, equality, membership, etc. ) 

10)Commands and their functions:

  1.Universal quantifier elimination. No argument or one argument specifying which quantified variable to eliminate. When it is called, a constant is introduced for the variable in domain.

  2.Existential quantifier elimination. No argument or one argument specifying which quantified variable to eliminate.

  3.Conjunction split. Split a conjunction into several subgoals and give them labels for distinguishing.

  4.Orientation of equational axioms. Substitute a certain structure in the goal which matches the left side of some axiom for the right side of it. Several arguments to specify which structure and which axiom to apply.

  5.Frame rule. From P1 -> P2, deduce sigma(Q1,...P1,...Qn) -> sigma(Q1,...P2,...Qn).

  6.Constraint propagation. The pattern to be propagated must be a predicate pattern. Two arguments to decide which pattern to propagate and propagate to which place. 

  7.Definiteness symbols treatment. Eliminate floor() and top().

  8.Case analysis.

  9.Magic wand (separating implication). When it is used, it’s then immediately changed to the specified structure automatically.

  10.structural induction.

  11.Current goal specification. When there are several subgoals, use label to select the goal to be solved.

  12.Showing rules / hypotheses. Show the rules and current hypotheses assumed for the current goal to help proving.

  13.Undo n steps. Go back n steps for a new try.


##Other thoughts:

  Every goal / subgoal should have a label to mark it. Every variable and operator inside a goal should also be given a label. We can also use marked parentheses to maintain hierarchy of a goal to locate certain variables and operators. Ex. ( a …(… a …)2 … b)1, (a in 1) refers to the first a. (This is in general an issue. First of all, there is a mechanism, called locations, to precisely specify subterms in a term. Think of a term, say f(g(a,b), h(c,d)), as a tree, and the subterm b is at {1,2} position. Secondly, this mechanism breaks because we want to take full advantage of Maude, especially its AC matching power. Therefore we very likely will implement the prover in a way such that the ML pattern f(g(a,b), h(c,d)) in which f is comm, is implemented as a Maude term f(g(a,b), h(c,d)) or something similar where f is comm, so it is not clear what the position {1,2} now points to (whether it’s a or c?). And this is exactly the time when we want to resort to Coq and ITP for help, because they are mature provers and whatever problems we meet here will also definitely appear in Coq and ITP, and they must already have a pretty decent solution to those. Therefore, instead of (or at least before) thinking of our solution, please look into Coq and ITP (in this case ITP seems to be able to provide more help) and see how they deal with the similar tactics and how they implement them.)
