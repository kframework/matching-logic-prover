type token =
  | ID of (string)
  | LPAREN
  | RPAREN
  | DECLSORT
  | DECLSYMB
  | DECLFUNC
  | ASSERT
  | CHECKSAT
  | GETMODEL
  | TOP
  | BOTTOM
  | AND
  | OR
  | NOT
  | IMPLIES
  | IFF
  | FORALL
  | EXISTS
  | EQUAL
  | FLOOR
  | CEIL
  | CONTAINS
  | EOF

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Convert
# 31 "parser.ml"
let yytransl_const = [|
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* DECLSORT *);
  261 (* DECLSYMB *);
  262 (* DECLFUNC *);
  263 (* ASSERT *);
  264 (* CHECKSAT *);
  265 (* GETMODEL *);
  266 (* TOP *);
  267 (* BOTTOM *);
  268 (* AND *);
  269 (* OR *);
  270 (* NOT *);
  271 (* IMPLIES *);
  272 (* IFF *);
  273 (* FORALL *);
  274 (* EXISTS *);
  275 (* EQUAL *);
  276 (* FLOOR *);
  277 (* CEIL *);
  278 (* CONTAINS *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\005\000\005\000\005\000\005\000\003\000\003\000\
\002\000\002\000\002\000\002\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\007\000\
\007\000\004\000\004\000\000\000"

let yylen = "\002\000\
\001\000\002\000\004\000\007\000\007\000\004\000\001\000\002\000\
\001\000\001\000\001\000\002\000\003\000\003\000\003\000\004\000\
\004\000\005\000\005\000\004\000\003\000\003\000\003\000\001\000\
\002\000\001\000\005\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\001\000\028\000\000\000\000\000\000\000\
\000\000\002\000\000\000\000\000\000\000\011\000\000\000\009\000\
\010\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\012\000\000\000\003\000\000\000\007\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\006\000\008\000\000\000\000\000\025\000\
\023\000\013\000\014\000\015\000\000\000\000\000\000\000\026\000\
\000\000\000\000\000\000\021\000\022\000\000\000\000\000\016\000\
\017\000\000\000\000\000\000\000\020\000\005\000\004\000\000\000\
\018\000\019\000\000\000\027\000"

let yydgoto = "\002\000\
\005\000\040\000\038\000\065\000\010\000\033\000\041\000"

let yysindex = "\010\000\
\001\000\000\000\001\255\000\000\000\000\012\255\014\255\019\255\
\042\255\000\000\255\254\033\255\037\255\000\000\013\255\000\000\
\000\000\044\255\001\000\009\255\009\255\042\255\042\255\042\255\
\042\255\042\255\042\255\046\255\047\255\042\255\042\255\042\255\
\000\000\001\000\000\000\009\255\000\000\049\255\050\255\042\255\
\051\255\052\255\056\255\059\255\042\255\042\255\043\255\043\255\
\042\255\060\255\061\255\000\000\000\000\062\255\063\255\000\000\
\000\000\000\000\000\000\000\000\064\255\065\255\068\255\000\000\
\042\255\042\255\067\255\000\000\000\000\001\000\001\000\000\000\
\000\000\070\255\069\255\071\255\000\000\000\000\000\000\072\255\
\000\000\000\000\043\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\073\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\246\255\247\255\239\255\211\255\000\000\000\000\018\000"

let yytablesize = 259
let yytable = "\018\000\
\004\000\019\000\066\000\039\000\006\000\007\000\008\000\009\000\
\035\000\036\000\001\000\037\000\011\000\022\000\012\000\044\000\
\045\000\046\000\053\000\013\000\049\000\050\000\051\000\052\000\
\023\000\024\000\025\000\026\000\027\000\028\000\029\000\030\000\
\031\000\032\000\020\000\061\000\062\000\084\000\021\000\067\000\
\042\000\043\000\014\000\015\000\063\000\064\000\034\000\047\000\
\048\000\054\000\055\000\016\000\017\000\057\000\058\000\075\000\
\076\000\056\000\059\000\078\000\079\000\060\000\068\000\069\000\
\070\000\071\000\072\000\073\000\074\000\077\000\080\000\081\000\
\000\000\082\000\083\000\024\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\003\000"

let yycheck = "\009\000\
\000\000\003\001\048\000\021\000\004\001\005\001\006\001\007\001\
\019\000\001\001\001\000\003\001\001\001\001\001\001\001\025\000\
\026\000\027\000\036\000\001\001\030\000\031\000\032\000\034\000\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\002\001\045\000\046\000\083\000\002\001\049\000\
\023\000\024\000\001\001\002\001\002\001\003\001\003\001\002\001\
\002\001\001\001\001\001\010\001\011\001\003\001\003\001\065\000\
\066\000\040\000\003\001\070\000\071\000\003\001\003\001\003\001\
\003\001\003\001\003\001\003\001\001\001\003\001\001\001\003\001\
\255\255\003\001\003\001\003\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\002\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  DECLSORT\000\
  DECLSYMB\000\
  DECLFUNC\000\
  ASSERT\000\
  CHECKSAT\000\
  GETMODEL\000\
  TOP\000\
  BOTTOM\000\
  AND\000\
  OR\000\
  NOT\000\
  IMPLIES\000\
  IFF\000\
  FORALL\000\
  EXISTS\000\
  EQUAL\000\
  FLOOR\000\
  CEIL\000\
  CONTAINS\000\
  EOF\000\
  "

let yynames_block = "\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 19 "parser.mly"
        ( initial_system )
# 224 "parser.ml"
               : Convert.system))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'system_cont) in
    Obj.repr(
# 20 "parser.mly"
                       ( _2 )
# 231 "parser.ml"
               : Convert.system))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Convert.system) in
    Obj.repr(
# 24 "parser.mly"
                              ( add_sort _2 _4 )
# 239 "parser.ml"
               : 'system_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : string list) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : Convert.system) in
    Obj.repr(
# 26 "parser.mly"
      ( add_func _2 _4 _5 _7 )
# 249 "parser.ml"
               : 'system_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : string list) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : Convert.system) in
    Obj.repr(
# 28 "parser.mly"
      ( add_nonfunc _2 _4 _5 _7 )
# 259 "parser.ml"
               : 'system_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Convert.pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Convert.system) in
    Obj.repr(
# 30 "parser.mly"
      ( add_axiom _2 _4 )
# 267 "parser.ml"
               : 'system_cont))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "parser.mly"
           ( [] )
# 273 "parser.ml"
               : string list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string list) in
    Obj.repr(
# 35 "parser.mly"
             ( _1 :: _2 )
# 281 "parser.ml"
               : string list))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parser.mly"
        ( TopPattern )
# 287 "parser.ml"
               : Convert.pattern))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
           ( BottomPattern )
# 293 "parser.ml"
               : Convert.pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 41 "parser.mly"
       ( AppPattern(_1, []) )
# 300 "parser.ml"
               : Convert.pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'pattern_cont) in
    Obj.repr(
# 42 "parser.mly"
                        ( _2 )
# 307 "parser.ml"
               : Convert.pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 45 "parser.mly"
                        ( AndPattern(_2) )
# 314 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 46 "parser.mly"
                       ( OrPattern(_2) )
# 321 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 47 "parser.mly"
                       ( NotPattern(_2) )
# 328 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Convert.pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 48 "parser.mly"
                                   ( ImpliesPattern(_2, _3) )
# 336 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Convert.pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 49 "parser.mly"
                               ( IffPattern(_2, _3) )
# 344 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : (string * string) list) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 51 "parser.mly"
      ( ForallPattern(_3, (replace_constants_if_binders _4 _3)) )
# 352 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : (string * string) list) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 53 "parser.mly"
      ( ExistsPattern(_3, (replace_constants_if_binders _4 _3)) )
# 360 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Convert.pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 54 "parser.mly"
                                 ( EqualPattern(_2, _3) )
# 368 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 55 "parser.mly"
                         ( FloorPattern(_2) )
# 375 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    Obj.repr(
# 56 "parser.mly"
                        ( CeilPattern(_2) )
# 382 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 57 "parser.mly"
                       ( AppPattern(_1, _2) )
# 390 "parser.ml"
               : 'pattern_cont))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Convert.pattern) in
    Obj.repr(
# 60 "parser.mly"
            ( [_1] )
# 397 "parser.ml"
               : 'patterns))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Convert.pattern) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'patterns) in
    Obj.repr(
# 61 "parser.mly"
                     ( _1::_2 )
# 405 "parser.ml"
               : 'patterns))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "parser.mly"
           ( [] )
# 411 "parser.ml"
               : (string * string) list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : (string * string) list) in
    Obj.repr(
# 67 "parser.mly"
                                ( (_2, _3) :: _5 )
# 420 "parser.ml"
               : (string * string) list))
(* Entry system *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let system (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Convert.system)
