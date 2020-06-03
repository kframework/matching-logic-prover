; Gets included whenever we call an SMT solver
(set-logic ALL_SUPPORTED)

( define-sort SetInt () ( Set Int ) )
( define-fun emptysetx () SetInt ( as emptyset SetInt ) )
( define-fun in ( ( n Int )  ( x SetInt )  ) Bool ( member n  x) )
( define-fun unionx ( ( x SetInt )  ( y SetInt )  ) SetInt ( union x y  ) )
( define-fun intersectx ( ( x SetInt )  ( y SetInt )  ) SetInt ( intersection x  y  ) )
( define-fun disjointx ( ( x SetInt )  ( y SetInt )  ) Bool ( = ( intersectx x  y  ) emptysetx ) )
( define-fun setAdd ( ( s SetInt )  ( x Int ) ) SetInt ( unionx s ( singleton x )) )
( define-fun setDel ( ( s SetInt )  ( x Int ) ) SetInt ( setminus s ( singleton x )) )
( define-fun max ( (x Int) (y Int) ) Int ( ite (< x y) y x ) )
