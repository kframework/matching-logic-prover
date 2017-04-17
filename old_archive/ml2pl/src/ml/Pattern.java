package ml;
import fol.Formula;

/**
 * Patterns are always obtained by apply a pattern maker upon a list of subpatterns.
 * Created by Xiaohong on 2/3/17.
 */
public abstract class Pattern {
    protected Sort sort;
    /**
     * Returns the current sort of the pattern, not assuming that the pattern is in the top level. That is, the pattern
     * may be a subpattern of some other patterns, and therefore has a constrained sort. This is often the case when
     * one calls {@link #resolveSorting()} on a top-level pattern, and the pattern, as a subpattern of the top-level
     * pattern, is assigned a sort from the context.
     * @return the sort of the pattern
     */
    public Sort getSort() { return sort; }

    /**
     * Resolves polymorphic sorting in a pattern, assuming that the pattern is not a subpattern of some other pattern.
     */
    public abstract void resolveSorting();

    /**
     * Transforms the pattern to a first-order formula, who has the same validity with the pattern.
     * @return a first-order formula who has the same validity with the pattern.
     */
    public abstract Formula toFirstOrderFormula();

    /**
     * Creates a first-order formula with the pattern and a given first-order variable, such that the first-order
     * formula is true iff the given first-order variable (regarded as a matching logic variable), matches the
     * pattern.
     * @param folVariable a fresh first-order variable
     * @return a first-order formula which is true iff the first-order variable, when regarded as a matching
     * logic variable, matches the pattern.
     */
    public abstract Formula toFirstOrderFormula(fol.Variable folVariable);
}
