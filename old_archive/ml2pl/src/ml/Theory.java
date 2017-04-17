package ml;

import java.util.List;

/**
 * Created by xiaohong on 2/2/17.
 */
public class Theory {
    private List<Sort> sortList;
    private List<Symbol> symbList;
    private List<Pattern> axiomList;

    public Theory(List<Sort> sortList, List<Symbol> symbList, List<Pattern> axiomList) {
        this.sortList = sortList;
        this.symbList = symbList;
        this.axiomList = axiomList;
    }

    public void addAxiom(Pattern ax) {
        this.axiomList.add(ax);
    }

    public List<Sort> getSortList() {
        return sortList;
    }

    public List<Symbol> getSymbList() {
        return symbList;
    }

    public List<Pattern> getAxiomList() {
        return axiomList;
    }
}
