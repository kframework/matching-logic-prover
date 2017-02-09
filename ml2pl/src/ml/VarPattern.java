package ml;

import fol.Formula;

/**
 * Created by Xiaohong on 2/8/17.
 */
public class VarPattern extends Pattern {
    private Variable variable;

    /**
     * Creates a variable pattern with the given name and sort.
     * @param name the name of the variable that forms the pattern
     * @param sort the sort of the variable that forms the pattern
     */
    public VarPattern(String name, Sort sort) {
        this.variable = new Variable(name, sort);
        this.sort = sort;
    }

    @Override
    public void resolveSorting() {
        return;
    }

    @Override
    public Formula ML2PL() {
        return null;
    }
}
