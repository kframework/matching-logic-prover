Entail LHS(x,y,u,v) |- RHS(x,y,u,v)


LHS(x,y,u,v) ::= TLL_plus(x,y,u,v)

RHS(x,y,u,v) ::= TLL_plus_rev(x,y,u,v)

TLL_plus(root,par,ll,lr) ::=  root->nil,nil,par,lr & root=ll |
  \E l,r,z . root->l,r,par,nil * TLL_plus(l,root,ll,z) * TLL_plus(r,root,z,lr)

TLL_aux(x,p,z,back,top,mright) ::=  \E up,r,lr . x->back,r,up,nil * TLL_aux(up,p,lr,x,top,mright) * TLL_plus(r,x,z,lr) |
  \E r . x->back,r,p,nil & x=top * TLL_plus(r,x,z,mright)

TLL_plus_rev(top,p,mleft,mright) ::=  top->nil,nil,p,mright & top=mleft |
  \E x,up,lr . x->nil,nil,up,lr & mleft=x * TLL_aux(up,p,lr,x,top,mright)
