"""
A general visitor base class
"""
class Visitor:
    """
    When a node.visit is called, proxy_visit_* will be called first, which will:
    1. call previsit_*
    2. call visit_children_of_* to visit all children
    3. call postvisit_* (with return values of the children visits)
    """

    def proxy_visit(self, name: str):
        def f(node):
            getattr(self, "previsit_" + name)(node)
            children = getattr(self, "visit_children_of_" + name)(node)
            return getattr(self, "postvisit_" + name)(node, *children)
        return f

    def previsit_default(self, x):
        return x

    def visit_children_of_default(self, x):
        return []

    def postvisit_default(self, x, *args):
        return x

    def visit(self, x):
        return x.visit(self)

    def __getattr__(self, name):
        if name.startswith("proxy_visit_"):
            return self.proxy_visit(name[len("proxy_visit_"):])
        elif name.startswith("previsit_"):
            return self.previsit_default
        elif name.startswith("visit_children_of_"):
            return self.visit_children_of_default
        elif name.startswith("postvisit_"):
            return self.postvisit_default
        else:
            raise AttributeError(name)
