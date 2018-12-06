Entail LHS(hd0,tl0,hd1,tl1,hd2,tl2,hd3,tl3,hd4,tl4,hd5,tl5,hd6,tl6,hd7,tl7,hd8,tl8,hd9,tl9,hd10,tl10,hd11,tl11,hd12,tl12,hd13,tl13,hd14,tl14,hd15,tl15,hd16,tl16,hd17,tl17,hd18,tl18,hd19,tl19,hd20,tl20) |- RHS(hd0,tl0,hd1,tl1,hd2,tl2,hd3,tl3,hd4,tl4,hd5,tl5,hd6,tl6,hd7,tl7,hd8,tl8,hd9,tl9,hd10,tl10,hd11,tl11,hd12,tl12,hd13,tl13,hd14,tl14,hd15,tl15,hd16,tl16,hd17,tl17,hd18,tl18,hd19,tl19,hd20,tl20)


LHS(hd0,tl0,hd1,tl1,hd2,tl2,hd3,tl3,hd4,tl4,hd5,tl5,hd6,tl6,hd7,tl7,hd8,tl8,hd9,tl9,hd10,tl10,hd11,tl11,hd12,tl12,hd13,tl13,hd14,tl14,hd15,tl15,hd16,tl16,hd17,tl17,hd18,tl18,hd19,tl19,hd20,tl20) ::= DLL2_plus(hd0,nil,tl0,hd1) * DLL2_plus(hd1,tl0,tl1,hd2) * DLL2_plus(hd2,tl1,tl2,hd3) * DLL2_plus(hd3,tl2,tl3,hd4) * DLL2_plus(hd4,tl3,tl4,hd5) * DLL2_plus(hd5,tl4,tl5,hd6) * DLL2_plus(hd6,tl5,tl6,hd7) * DLL2_plus(hd7,tl6,tl7,hd8) * DLL2_plus(hd8,tl7,tl8,hd9) * DLL2_plus(hd9,tl8,tl9,hd10) * DLL2_plus(hd10,tl9,tl10,hd11) * DLL2_plus(hd11,tl10,tl11,hd12) * DLL2_plus(hd12,tl11,tl12,hd13) * DLL2_plus(hd13,tl12,tl13,hd14) * DLL2_plus(hd14,tl13,tl14,hd15) * DLL2_plus(hd15,tl14,tl15,hd16) * DLL2_plus(hd16,tl15,tl16,hd17) * DLL2_plus(hd17,tl16,tl17,hd18) * DLL2_plus(hd18,tl17,tl18,hd19) * DLL2_plus(hd19,tl18,tl19,hd20) * DLL2_plus(hd20,tl19,tl20,nil)

RHS(hd0,tl0,hd1,tl1,hd2,tl2,hd3,tl3,hd4,tl4,hd5,tl5,hd6,tl6,hd7,tl7,hd8,tl8,hd9,tl9,hd10,tl10,hd11,tl11,hd12,tl12,hd13,tl13,hd14,tl14,hd15,tl15,hd16,tl16,hd17,tl17,hd18,tl18,hd19,tl19,hd20,tl20) ::= \E hd1,tl1,hd2,tl2,hd3,tl3,hd4,tl4,hd5,tl5,hd6,tl6,hd7,tl7,hd8,tl8,hd9,tl9,hd10,tl10,hd11,tl11,hd12,tl12,hd13,tl13,hd14,tl14,hd15,tl15,hd16,tl16,hd17,tl17,hd18,tl18,hd19,tl19 . DLL2_plus_rev(hd0,nil,tl0,hd1) * DLL2_plus_rev(hd1,tl0,tl1,hd2) * DLL2_plus_rev(hd2,tl1,tl2,hd3) * DLL2_plus_rev(hd3,tl2,tl3,hd4) * DLL2_plus_rev(hd4,tl3,tl4,hd5) * DLL2_plus_rev(hd5,tl4,tl5,hd6) * DLL2_plus_rev(hd6,tl5,tl6,hd7) * DLL2_plus_rev(hd7,tl6,tl7,hd8) * DLL2_plus_rev(hd8,tl7,tl8,hd9) * DLL2_plus_rev(hd9,tl8,tl9,hd10) * DLL2_plus_rev(hd10,tl9,tl10,hd11) * DLL2_plus_rev(hd11,tl10,tl11,hd12) * DLL2_plus_rev(hd12,tl11,tl12,hd13) * DLL2_plus_rev(hd13,tl12,tl13,hd14) * DLL2_plus_rev(hd14,tl13,tl14,hd15) * DLL2_plus_rev(hd15,tl14,tl15,hd16) * DLL2_plus_rev(hd16,tl15,tl16,hd17) * DLL2_plus_rev(hd17,tl16,tl17,hd18) * DLL2_plus_rev(hd18,tl17,tl18,hd19) * DLL2_plus_rev(hd19,tl18,tl19,hd20) * DLL2_plus_rev(hd20,tl19,tl20,nil)

DLL1_plus(hd,p) ::=  hd->nil,p |
  \E x . hd->x,p * DLL1_plus(x,hd)

DLL2_plus(hd,p,tl,n) ::=  \E down_hd . hd->n,p,down_hd & hd=tl * DLL1_plus(down_hd,hd) |
  \E x,down_hd . hd->x,p,down_hd * DLL1_plus(down_hd,hd) * DLL2_plus(x,hd,tl,n)

DLL2_plus_rev(hd,p,tl,n) ::=  \E down_hd . hd->n,p,down_hd & hd=tl * DLL1_plus(down_hd,hd) |
  \E x,down_hd . tl->n,x,down_hd * DLL1_plus(down_hd,tl) * DLL2_plus_rev(hd,p,x,tl)
