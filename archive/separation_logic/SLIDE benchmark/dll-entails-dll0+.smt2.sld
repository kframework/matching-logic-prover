Entail LHS(a,c) |- RHS(a,c)


LHS(a,c) ::= DLL_plus(a,nil,c,nil)

RHS(a,c) ::= DLL(a,nil,c,nil)

DLL_plus(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . hd->x,p * DLL_plus(x,hd,tl,n)

DLL(hd,p,tl,n) ::=  p=tl & hd=n & emp |
  \E x . hd->x,p * DLL(x,hd,tl,n)
