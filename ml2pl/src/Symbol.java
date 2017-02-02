import java.util.ArrayList;
import java.util.List;

/**
 * Created by xiaohong on 2/2/17.
 */
public class Symbol {
    private String name;
    private List<Sort> domSortList;
    private Sort codomainSort;

    public Symbol(String name, Sort s){
        this.name = name;
        this.domSortList = new ArrayList<Sort>();
        this.codomainSort = s;
    }

    public Symbol(String name, Sort s1, Sort s){
        this.name = name;
        this.domSortList = new ArrayList<Sort>();
        this.domSortList.add(s1);
        this.codomainSort = s;
    }

    public Symbol(String name, Sort s1, Sort s2, Sort s){
        this.name = name;
        this.domSortList = new ArrayList<>();
        this.domSortList.add(s1);
        this.domSortList.add(s2);
        this.codomainSort = s;
    }

    public List<Sort> getDomSortList() {
        return domSortList;
    }

    public Sort getCodomainSort() {
        return codomainSort;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
