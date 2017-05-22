type token =
  | ID of (string)
  | LPAREN
  | RPAREN
  | DECLSORT
  | DECLSYMB
  | DECLPART
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
open Pat
# 32 "parser.ml"
let yytransl_const = [|
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* DECLSORT *);
  261 (* DECLSYMB *);
  262 (* DECLPART *);
  263 (* DECLFUNC *);
  264 (* ASSERT *);
  265 (* CHECKSAT *);
  266 (* GETMODEL *);
  267 (* TOP *);
  268 (* BOTTOM *);
  269 (* AND *);
  270 (* OR *);
  271 (* NOT *);
  272 (* IMPLIES *);
  273 (* IFF *);
  274 (* FORALL *);
  275 (* EXISTS *);
  276 (* EQUAL *);
  277 (* FLOOR *);
  278 (* CEIL *);
  279 (* CONTAINS *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\008\000\008\000\008\000\008\000\008\000\006\000\
\007\000\009\000\009\000\002\000\002\000\002\000\002\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\004\000\004\000\005\000\010\000\010\000\
\000\000\000\000"

let yylen = "\002\000\
\001\000\002\000\004\000\006\000\006\000\006\000\004\000\001\000\
\002\000\001\000\002\000\001\000\001\000\001\000\002\000\002\000\
\002\000\003\000\004\000\004\000\004\000\004\000\004\000\003\000\
\003\000\004\000\002\000\001\000\002\000\002\000\001\000\005\000\
\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\001\000\033\000\014\000\000\000\
\012\000\013\000\034\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
\000\000\000\000\000\000\028\000\000\000\027\000\016\000\017\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\029\000\018\000\000\000\000\000\000\000\031\000\030\000\000\000\
\000\000\000\000\025\000\024\000\000\000\003\000\000\000\010\000\
\009\000\008\000\000\000\000\000\000\000\007\000\019\000\020\000\
\000\000\021\000\022\000\023\000\026\000\011\000\000\000\000\000\
\000\000\000\000\004\000\006\000\005\000\000\000\032\000"

let yydgoto = "\003\000\
\006\000\037\000\030\000\038\000\045\000\075\000\053\000\017\000\
\073\000\063\000"

let yysindex = "\010\000\
\001\000\045\255\000\000\002\255\000\000\000\000\000\000\015\255\
\000\000\000\000\000\000\022\255\038\255\041\255\054\255\045\255\
\000\000\051\255\051\255\051\255\045\255\045\255\045\255\062\255\
\062\255\045\255\045\255\045\255\045\255\000\000\063\255\065\255\
\065\255\065\255\066\255\000\000\051\255\000\000\000\000\000\000\
\067\255\045\255\045\255\000\255\045\255\045\255\045\255\068\255\
\069\255\045\255\001\000\014\255\064\255\064\255\064\255\001\000\
\000\000\000\000\070\255\071\255\074\255\000\000\000\000\073\255\
\075\255\076\255\000\000\000\000\077\255\000\000\014\255\000\000\
\000\000\000\000\078\255\079\255\080\255\000\000\000\000\000\000\
\083\255\000\000\000\000\000\000\000\000\000\000\001\000\001\000\
\001\000\082\255\000\000\000\000\000\000\000\255\000\000"

let yyrindex = "\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\218\255\254\255\000\000\241\255\043\000\004\000\027\000\000\000\
\006\000\248\255"

let yytablesize = 259
let yytable = "\011\000\
\005\000\061\000\062\000\039\000\040\000\012\000\013\000\014\000\
\015\000\016\000\001\000\002\000\070\000\035\000\071\000\018\000\
\072\000\078\000\041\000\042\000\043\000\057\000\031\000\047\000\
\048\000\049\000\050\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\026\000\027\000\028\000\029\000\032\000\059\000\
\060\000\033\000\064\000\065\000\066\000\007\000\008\000\069\000\
\091\000\092\000\093\000\007\000\008\000\036\000\034\000\009\000\
\010\000\076\000\077\000\054\000\055\000\009\000\010\000\044\000\
\074\000\051\000\052\000\046\000\056\000\058\000\067\000\068\000\
\079\000\080\000\081\000\082\000\086\000\083\000\084\000\085\000\
\087\000\088\000\089\000\090\000\094\000\095\000\000\000\000\000\
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
\000\000\000\000\004\000"

let yycheck = "\002\000\
\000\000\002\001\003\001\019\000\020\000\004\001\005\001\006\001\
\007\001\008\001\001\000\002\000\051\000\016\000\001\001\001\001\
\003\001\056\000\021\000\022\000\023\000\037\000\001\001\026\000\
\027\000\028\000\029\000\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\001\001\042\000\
\043\000\001\001\045\000\046\000\047\000\001\001\002\001\050\000\
\087\000\088\000\089\000\001\001\002\001\003\001\001\001\011\001\
\012\001\054\000\055\000\033\000\034\000\011\001\012\001\002\001\
\001\001\003\001\002\001\025\000\003\001\003\001\003\001\003\001\
\003\001\003\001\001\001\003\001\071\000\003\001\003\001\003\001\
\003\001\003\001\003\001\001\001\003\001\094\000\255\255\255\255\
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
  DECLPART\000\
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
# 24 "parser.mly"
        ( ([], [], []) )
# 234 "parser.ml"
               : (string list) * (Pat.sym list) * (Pat.pat list)))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'thy_closed) in
    Obj.repr(
# 25 "parser.mly"
                      ( _2 )
# 241 "parser.ml"
               : (string list) * (Pat.sym list) * (Pat.pat list)))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : (string list) * (Pat.sym list) * (Pat.pat list)) in
    Obj.repr(
# 28 "parser.mly"
                           ( add_sort_pat _2 _4 )
# 249 "parser.ml"
               : 'thy_closed))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string list) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : (string list) * (Pat.sym list) * (Pat.pat list)) in
    Obj.repr(
# 29 "parser.mly"
                                      ( add_sym_pat (UI(_2, _3, _4)) _6 )
# 259 "parser.ml"
               : 'thy_closed))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string list) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : (string list) * (Pat.sym list) * (Pat.pat list)) in
    Obj.repr(
# 30 "parser.mly"
                                      ( add_sym_pat (FC(_2, _3, _4)) _6 )
# 269 "parser.ml"
               : 'thy_closed))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string list) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : (string list) * (Pat.sym list) * (Pat.pat list)) in
    Obj.repr(
# 31 "parser.mly"
                                      ( add_sym_pat (PF(_2, _3, _4)) _6 )
# 279 "parser.ml"
               : 'thy_closed))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pat.pat) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : (string list) * (Pat.sym list) * (Pat.pat list)) in
    Obj.repr(
# 32 "parser.mly"
                          ( add_axiom_pat _2 _4 )
# 287 "parser.ml"
               : 'thy_closed))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
       ( _1 )
# 294 "parser.ml"
               : string))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sorts_closed) in
    Obj.repr(
# 38 "parser.mly"
                        ( _2 )
# 301 "parser.ml"
               : string list))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parser.mly"
           ( [] )
# 307 "parser.ml"
               : 'sorts_closed))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sorts_closed) in
    Obj.repr(
# 42 "parser.mly"
                    ( _1 :: _2 )
# 315 "parser.ml"
               : 'sorts_closed))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
        ( Top )
# 321 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parser.mly"
           ( Bottom )
# 327 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 47 "parser.mly"
       ( Id(_1) )
# 334 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pat.pat) in
    Obj.repr(
# 48 "parser.mly"
                      ( _2 )
# 341 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pat.pat list) in
    Obj.repr(
# 51 "parser.mly"
                    ( And(_2) )
# 348 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pat.pat list) in
    Obj.repr(
# 52 "parser.mly"
                   ( Or(_2) )
# 355 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 53 "parser.mly"
                   ( Not(_2) )
# 362 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pat.pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 54 "parser.mly"
                           ( Implies(_2, _3) )
# 370 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pat.pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 55 "parser.mly"
                       ( Iff(_2, _3) )
# 378 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : (string * string) list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 56 "parser.mly"
                               ( Forall(_2, _3) )
# 386 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : (string * string) list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 57 "parser.mly"
                               ( Exists(_2, _3) )
# 394 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pat.pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 58 "parser.mly"
                         ( Equal(_2, _3) )
# 402 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 59 "parser.mly"
                    ( Ceil(_2) )
# 409 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 60 "parser.mly"
                     ( Floor(_2) )
# 416 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Pat.pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    Obj.repr(
# 61 "parser.mly"
                            ( Contains(_2, _3) )
# 424 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pat.pat list) in
    Obj.repr(
# 62 "parser.mly"
                   ( App(_1, _2) )
# 432 "parser.ml"
               : Pat.pat))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "parser.mly"
           ( [] )
# 438 "parser.ml"
               : Pat.pat list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Pat.pat) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pat.pat list) in
    Obj.repr(
# 66 "parser.mly"
                    ( _1 :: _2 )
# 446 "parser.ml"
               : Pat.pat list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bindings_closed) in
    Obj.repr(
# 70 "parser.mly"
                           ( _2 )
# 453 "parser.ml"
               : (string * string) list))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "parser.mly"
           ( [] )
# 459 "parser.ml"
               : 'bindings_closed))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'bindings_closed) in
    Obj.repr(
# 74 "parser.mly"
                                        ( (_2, _3) :: _5 )
# 468 "parser.ml"
               : 'bindings_closed))
(* Entry thy *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry pat *)
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
let thy (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : (string list) * (Pat.sym list) * (Pat.pat list))
let pat (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Pat.pat)
