open Convert
open Printf

let file_in = "example.match";;
let input_channel = open_in file_in;;

let file_out = "example.smt";;
let output_channel = open_out file_out;;

try
  let lexbuf = Lexing.from_channel input_channel in
  while true do
    let pat = Parser.pattern Lexer.token lexbuf in
    fprintf output_channel "%s\n" (pattern2string pat); 
    flush output_channel;
    flush stdout
  done
with Lexer.Eof ->
  print_string "error\n";
  exit 0
;;

close_in input_channel;;
close_out output_channel;;

