# Matching Logic Prover

## Interactive Prover
* Change directory to `interactive_prover/`.

  `cd interactive_prover`
  
* Install Maude System. 
 
  `sudo apt install maude`
 
* Run tests and highlight results.

  `maude tests | grep -E -1024 "(true|false)"`

## Convertion from Matching Logic to First-Order Logic
* Change directory to `ml2fol_conversion/`.

  `cd ml2fol_conversion`
  
* Install Ocaml 4.02.3.

  `sudo apt install ocaml`
  
* Build the converter.

  `./build`
  
* Write matching logic specification in `example.match`.

* Convert to `example.smt2`.

  `./ml2fol`

## Technical Report
