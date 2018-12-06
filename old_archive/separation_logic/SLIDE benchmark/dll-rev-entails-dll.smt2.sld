Entail LHS(x,y) |- RHS(x,y)


LHS(x,y) ::= DLL_plus_rev(x,nil,y,nil)

RHS(x,y) ::= DLL_plus(x,nil,y,nil)

DLL_plus(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . hd->x,p * DLL_plus(x,hd,tl,n)

DLL_plus_rev(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . tl->n,x * DLL_plus_rev(hd,p,x,tl)
