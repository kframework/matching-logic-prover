/**
 * Created by Xiaohong on 2/3/17.
 */
public class Pattern {
    private Sort sort;
    private

    /**
     * Resolve polymorphic sorting information for pattern and its subpatterns.
     * The sort of a (polymorphic) pattern depends on the context where it is.
     */
    void resolveSorting();

    /**
     * Get the sort of a pattern. The method calls {@link #resolveSorting()} before
     * it returns.
     * @return the sort of the pattern.
     */
    public Sort getSort() {
        resolveSorting();
        return sort;
    }
}
