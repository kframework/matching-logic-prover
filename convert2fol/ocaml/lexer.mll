{ open Parser
}
rule token = parse
  | [' ' '\t' '\n']		{token lexbuf}
  | [