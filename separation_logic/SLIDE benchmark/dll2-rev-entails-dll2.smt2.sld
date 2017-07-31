Entail LHS(x,y,u,v) |- RHS(x,y,u,v)


LHS(x,y,u,v) ::= DLL2_plus_rev(x,y,u,v)

RHS(x,y,u,v) ::= DLL2_plus(x,y,u,v)

DLL1_plus(hd,p) ::=  hd->nil,p |
  \E x . hd->x,p * DLL1_plus(x,hd)

DLL2_plus(hd,p,tl,n) ::=  \E down_hd . hd->n,p,down_hd & hd=tl * DLL1_plus(down_hd,hd) |
  \E x,down_hd . hd->x,p,down_hd * DLL1_plus(down_hd,hd) * DLL2_plus(x,hd,tl,n)

DLL2_plus_rev(hd,p,tl,n) ::=  \E down_hd . hd->n,p,down_hd & hd=tl * DLL1_plus(down_hd,hd) |
  \E x,down_hd . tl->n,x,down_hd * DLL1_plus(down_hd,tl) * DLL2_plus_rev(hd,p,x,tl)
