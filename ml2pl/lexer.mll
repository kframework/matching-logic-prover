{
open Parser
exception Eof
}

rule token = parse
  | [' ' '\t']		{ token lexbuf }    (* skip blanks *)
  | ['\n']          { EOL }
  | ["axiom"]       { AXIOM }
  | ["conjecture"]  { CONJECTURE }
  | ["/\\"]         { AND }
  | ["\\/"]         { OR }
  | ["forall"]      { FORALL }
  | ["exists"]      { EXISTS }
  | ["
