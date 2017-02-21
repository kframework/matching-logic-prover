package ml;

import java.util.List;

/**
 * Created by Xiaohong on 2/2/17.
 */

public final class Sort {

    private final String name;

    /**
     * Creates a sort with a name.
     * @param name
     */
    public Sort(String name){
        this.name = name;
    }

    /**
     * Returns the name of the sort.
     * @return the name of the sort.
     */
    public String getName() {
        return name;
    }

    /**
     * Checks whether the sort is the top sort, i.e., the name of the sort is "top".
     * @return true if the sort is the top sort.
     */
    public boolean isTopSort() { return this.name.equals("top"); }

    /**
     * Checks whether the sort is the bottom sort, i.e., the name of the sort is "bottom".
     * @return true if the sort is the bottom sort.
     */
    public boolean isBottomSort() { return this.name.equals("bottom"); }

    /**
     * Returns the infimum (the greatest lower bound) of two sorts.
     * The order of arguments of this method does not matter.
     * @param s1 a sort
     * @param s2 a sort
     * @return the infimum of two sorts.
     */
    public static Sort infimum(Sort s1, Sort s2) {
        if(s1.isTopSort()) { return s2; }
        if(s2.isTopSort()) { return s1; }
        if(s1.equals(s2)) { return s1; }
        return new Sort("bottom");
    }

    /**
     * Returns the infimum (the greatest lower bound) of a list of sorts.
     * The order of sorts in the list does not matter.
     * The infimum of an empty list of sorts is, by definition, the top sort.
     * @param sortList a list of sorts
     * @return the infimum of a list of sorts.
     */
    public static Sort infimum(List<Sort> sortList) {
        //TODO
        return new Sort("top");
    }
}
