open Convert
open Printf

let file_in = "example.match";;
let input_channel = open_in file_in;;

let file_out = "example.smt";;
let output_channel = open_out file_out;;

let lexbuf = Lexing.from_channel input_channel in
  let sys = Parser.system Lexer.token lexbuf in
  let patoutput = system2string sys in
  let smtoutput = theory2string (convert_system sys) in
  fprintf output_channel "%s\n" smtoutput; 
  flush output_channel;
  fprintf stdout "%s\n" (patoutput ^ "\n" ^ smtoutput); 
  flush stdout
;;

close_in input_channel;;
close_out output_channel;;

