open Printf

(* File calc.ml *)

let file_in = "example.match";;
let input_channel = open_in file_in;;

let file_out = "example.smt";;
let output_channel = open_out file_out;;

try
  let lexbuf = Lexing.from_channel input_channel in
    let result = Parser.main Lexer.token lexbuf in
      print_int result; 
      print_newline(); 
	  flush stdout;
	  fprintf output_channel "%d\n" result; 
	  flush output_channel
with Lexer.Eof ->
  print_string "error\n";
  exit 0
