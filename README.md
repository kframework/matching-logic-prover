# Matching Logic Prover

## What is the final goal and what has been done?

We aim for an automated deductive system for matching logic [1]. The overall goal here, as said in Stanford Encyclopedia of Philosophy [2], is "to mechanize reasoning" in matching logic as much and efficiently as possible. 

The main product that this project will deliver is an automated theorem prover for matching logic, aka, the mlprover. At present, the mlprover is in its prototype. It knows matching logic axioms and inference rules, and know how to apply a inference rule to generate from an existing proof obligation new proof obligations. It knows and recognizes an axiom and resolve them whenver the users request. In its current status, it serves as a full-functional proving assistant: it is the user, not the program, who do the proof. The program just takes commands from the user and do it is asked to do, mostly rewriting terms to terms.

A very basic inference system for the Hilbert-style proof system of propositional logic has been implemented in prop-logic.maude. From there, a deductive system for matching logic was developed in a similar but much more large scale manner. The main part of the work consist of the syntax of matching logic (syntax.maude) together with an inference system for matching logc (deduction.maude). Two examples were provided.

## Reference

[1] Grigore Rosu, Matching Logic -- Extended Abstract, Proceedings of the 26th International Conference on Rewriting Techniques and Applications (RTA'15), 2015
[2] Automated Reasoning, https://plato.stanford.edu/entries/reasoning-automated/
[3] The Maude System, http://maude.cs.illinois.edu/

