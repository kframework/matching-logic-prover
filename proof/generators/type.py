

"""
Given a pattern phi, generate a proof for
#Pattern phi
"""
class TypePatternProofGenerator(KoreVisitor):
    def __init__(self, env: ProofEnvironment):
        self.env = env

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_sort_instance(sort_instance)
        to_pattern = self.env.get_entity_info("constant", constant_symbol, "pattern")

        proof = []
        
        for arg in sort_instance.arguments:
            proof += arg.visit(self)
        
        return proof + [ to_pattern ]

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> List[str]:
        return [
            self.env.get_entity_info("variable", sort_variable.name, "type"),
            self.env.get_entity_info("prelude", "metavariable", "element-var-pattern"),
        ]

    def postvisit_variable(self, var: Variable) -> List[str]:
        if var.is_set_variable:
            to_pattern = self.env.get_entity_info("prelude", "metavariable", "set-var-pattern")
        else:
            to_pattern = self.env.get_entity_info("prelude", "metavariable", "element-var-pattern")
        variable_type = self.env.get_entity_info("variable", var.name, "type")
        return [ variable_type, to_pattern ]

    def postvisit_string_literal(self, literal: StringLiteral) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_string_literal(literal)
        return [
            self.env.get_entity_info("constant", constant_symbol, "pattern")
        ]

    def postvisit_application(self, application: Application) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        to_pattern = self.env.get_entity_info("constant", constant_symbol, "pattern")

        proof = []
        for arg in application.symbol.sort_arguments + application.arguments:
            proof += arg.visit(self)
        return proof + [ to_pattern ]

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> List[str]:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)

        if encoded_construct == KorePatternEncoder.FORALL or \
           encoded_construct == KorePatternEncoder.EXISTS:
            var = ml_pattern.get_binding_variable()
            var_is_element_var = self.env.get_entity_info("variable", var.name, "type")

            sort_is_pattern = var.sort.visit(self)
            body_is_pattern = ml_pattern.arguments[1].visit(self)

            meta_subst_proof = self.env.gen_meta_variable_substition({
                "ph1": sort_is_pattern,
                "x": [ var_is_element_var ],
                "ph2":  body_is_pattern,
            })

            return meta_subst_proof + [
                self.env.get_entity_info("prelude", KorePatternEncoder.FORALL, "pattern")
            ]
        else:
            to_pattern = self.env.get_entity_info("prelude", encoded_construct, "pattern")
            meta_subst_proof = self.env.gen_meta_variable_substition({
                "ph" + str(i + 1): arg.visit(self) for i, arg in enumerate(ml_pattern.sorts + ml_pattern.arguments)
            })
            return meta_subst_proof + [ to_pattern ]
