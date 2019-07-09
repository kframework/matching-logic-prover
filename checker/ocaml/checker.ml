open String

(* String encoding of AML patterns:
  * element variables: \ev(_)
  * set variables    : \sv(_)
  * constant symbols : \cs(_)
  * bottom           : \bt()
  * application      : \ap(_,_)
  * implies          : \im(_,_)
  * exists           : \ex(_,_)
  * least fixpoints  : \mu(_,_)
  *)

let get_head s = s.[3]

let get_fst s = 
