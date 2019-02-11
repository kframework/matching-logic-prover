Entail LHS(x,y) |- RHS(x,y)


LHS(x,y) ::= DLL_plus_rev(x,nil,y,nil)

RHS(x,y) ::= DLL_plus_mid(x,nil,y,nil)

points_to(a,b,c) ::=  a->b,c

DLL_plus(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . hd->x,p * DLL_plus(x,hd,tl,n)

DLL_plus_rev(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  \E x . tl->n,x * DLL_plus_rev(hd,p,x,tl)

DLL_plus_mid(hd,p,tl,n) ::=  hd->n,p & hd=tl |
  hd->tl,p * points_to(tl,n,hd) |
  \E x,y,z . x->y,z * DLL_plus(y,x,tl,n) * DLL_plus_rev(hd,p,z,x)
