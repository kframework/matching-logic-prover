Entail LHS(a,c) |- RHS(a,c)


LHS(a,c) ::= \E l,r,z . a->l,r,nil,nil * TLL_plus(l,a,c,z) * TLL_plus(r,a,z,nil)

RHS(a,c) ::= TLL_plus(a,nil,c,nil)

TLL_plus(root,par,ll,lr) ::=  root->nil,nil,par,lr & root=ll |
  \E l,r,z . root->l,r,par,nil * TLL_plus(l,root,ll,z) * TLL_plus(r,root,z,lr)
