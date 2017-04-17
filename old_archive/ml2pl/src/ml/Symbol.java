package ml;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Xiaohong on 2/2/17.
 */
public class Symbol {
    private String name;
    private List<Sort> domainSortList;
    private Sort rangeSort;

    /**
     * Creates a zero-arity symbol with a name and a range sort.
     * @param name the name of the symbol.
     * @param s the range sort of the symbol.
     */
    public Symbol(String name, Sort s){
        this.name = name;
        this.domainSortList = new ArrayList<Sort>();
        this.rangeSort = s;
    }

    /**
     * Creates a one-arity symbol with a name, a domain sort, and a range sort.
     * @param name the name of the symbol.
     * @param s1 the sort of the argument.
     * @param s the range sort of the symbol.
     */
    public Symbol(String name, Sort s1, Sort s){
        this.name = name;
        this.domainSortList = new ArrayList<Sort>();
        this.domainSortList.add(s1);
        this.rangeSort = s;
    }

    /**
     * Creates a two-arity symbol with a name, two domain sort,
     * and a range sort.
     * @param name the name of the symbol.
     * @param s1 the sort of the first argument.
     * @param s2 the sort of the second argument.
     * @param s the range sort of the symbol.
     */
    public Symbol(String name, Sort s1, Sort s2, Sort s){
        this.name = name;
        this.domainSortList = new ArrayList<>();
        this.domainSortList.add(s1);
        this.domainSortList.add(s2);
        this.rangeSort = s;
    }

    /**
     * Checks whether the symbol is polymorphic, i.e., whether it has an argument of the sort named "topsort",
     * or whether its range sort is the sort named "topsort".
     * @return true if the symbol is polymorphic. Otherwise, returns false.
     */
    public boolean isPolymorphic(){
        if(rangeSort.isTopSort()) { return true; }
        for (Sort s: domainSortList) {
            if(s.isTopSort()) { return true; }
        }
        return false;
    }

    /**
     * Returns the list of domain sorts.
     * @return the list of domain sorts.
     */
    public List<Sort> getDomainSortList() {
        return domainSortList;
    }

    /**
     * Returns the range sort.
     * @return the range sort.
     */
    public Sort getRangeSort() {
        return rangeSort;
    }

    /**
     * Returns the name of the symbol.
     * @return the name of the symbol.
     */
    public String getName() {
        return name;
    }

}
