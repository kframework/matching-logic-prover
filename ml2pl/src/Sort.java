/**
 * Created by Xiaohong on 2/2/17.
 */

public class Sort {

    private String name;

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

    public boolean isTopSort() { return this.name.equals("topsort"); }
}
