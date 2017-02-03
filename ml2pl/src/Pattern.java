/**
 * Created by Xiaohong on 2/3/17.
 */
public abstract class Pattern {
    private Sort sort;

    /**
     * Resolve sorting information for pattern and its subpatterns.
     */
    protected abstract void resolveSorting();

    /**
     * Get the sort of a pattern.
     * @return Sort of the pattern.
     */
    public Sort getSort() {
        resolveSorting();
        return sort;
    }
}
