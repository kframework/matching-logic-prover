Entail LHS(x,y) |- RHS(x,y)


LHS(x,y) ::= TPP_plus_rev(x,y)

RHS(x,y) ::= TPP_plus(x,y)

TPP_plus(x,back) ::=  x->nil,nil,back |
  \E y,z . x->y,z,back * TPP_plus(y,x) * TPP_plus(z,x)

TPP_aux(x,down,top,b) ::=  \E up,right . x->down,right,up * TPP_plus(right,x) * TPP_aux(up,x,top,b) |
  \E up,left . x->left,down,up * TPP_plus(left,x) * TPP_aux(up,x,top,b) |
  \E right . x->down,right,b & x=top * TPP_plus(right,x) |
  \E left . x->left,down,b & x=top * TPP_plus(left,x)

TPP_plus_rev(top,b) ::=  top->nil,nil,b |
  \E x,up . x->nil,nil,up * TPP_aux(up,x,top,b)
