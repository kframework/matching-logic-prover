type sort = Bool | Nat | Seq | Map ;;
type symbol_type = sort list * sort ;;

type variable = string * sort ;;
type symbol = string * symbol_type ;;

type pattern = 
  | VarPattern(variable)
  | AppPattern(symbol, pattern list)
  | 
