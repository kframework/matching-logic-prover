open Convert
open Printf

let file_in = "example.match";;
let input_channel = open_in file_in;;

let file_out = "example.smt";;
let output_channel = open_out file_out;;

let lexbuf = Lexing.from_channel input_channel in
  let sys = Parser.main Lexer.token lexbuf in
  let smtoutput = theory2string (convert_system sys) in
  fprintf output_channel "%s\n" smtoutput; 
  flush output_channel;
  fprintf stdout "%s\n" smtoutput; 
  flush stdout
;;

close_in input_channel;;
close_out output_channel;;

