Entail LHS(a,c) |- RHS(a,c)


LHS(a,c) ::= \E x,n,b . x->n,b * DLL_plus_rev(a,nil,b,x) * DLL_plus(n,x,c,nil)

RHS(a,c) ::= DLL_plus(a,nil,c,nil)

DLL_plus(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . hd->x,p * DLL_plus(x,hd,tl,n)

DLL_plus_rev(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . tl->n,x * DLL_plus_rev(hd,p,x,tl)
