theory Matching_Logic
imports Main
begin

type_synonym variable = "string"

datatype pattern = 
  TopPattern
  | BottomPattern
  | VariablePattern variable
  | AndPattern pattern pattern
  | OrPattern  pattern pattern
  | ImpliesPattern pattern pattern
  | IffPattern pattern pattern
  | ExistsPattern variable pattern
  | ForallPattern variable pattern



end