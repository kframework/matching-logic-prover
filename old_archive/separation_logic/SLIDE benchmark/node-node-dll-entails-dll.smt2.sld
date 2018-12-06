Entail LHS(x,c) |- RHS(x,c)


LHS(x,c) ::= \E y,a . points_to(x,y,nil) * points_to(y,a,x) * DLL_plus(a,y,c,nil)

RHS(x,c) ::= DLL_plus(x,nil,c,nil)

points_to(a,b,c) ::=  a->b,c

DLL_plus(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . hd->x,p * DLL_plus(x,hd,tl,n)
