import java.util.Arrays;

/**
 * A MatchingLogicSorts object is basically a container that contains
 * some sorts. Each sort has its unique name. Examples of sort object
 * includes "Int", "Bool", "Map", etc.
 * Created by Xiaohong on 10/25/16.
 */
public class MatchingLogicSorts {

    private String[] sorts;

    /**
     * Create a MatchingLogicSorts object from a set of sort names.
     * @param sortnames the names of the sorts
     */
    public MatchingLogicSorts(String... sortnames){
        int numberofsorts = sortnames.length;
        sorts = new String[sortnames.length];
        for(int i = 0; i < numberofsorts; i++)
            sorts[i] = sortnames[i];
    }

    public String toString(){
        return Arrays.toString(sorts);
    }
}
