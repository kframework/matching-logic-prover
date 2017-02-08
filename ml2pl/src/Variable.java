/**
 * Created by xiaohong on 2/8/17.
 */
public final class Variable {
    private final String name;
    private final Sort sort;

    /**
     * Creates a variable with a name and a sort.
     * A variable must have a regular sort. A variable
     * can not be of the top sort or the bottom sort.
     * @param name the name of the variable
     * @param sort the sort of the variable
     */
    public Variable(String name, Sort sort) {
        assert !sort.isTopSort() && !sort.isBottomSort();
        this.name = name;
        this.sort = sort;
    }
}
