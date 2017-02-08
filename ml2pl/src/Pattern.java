import java.util.List;

/**
 * Patterns are always obtained by apply a pattern maker upon a list of subpatterns.
 * Created by Xiaohong on 2/3/17.
 */
public class Pattern {
    private Sort sort;
    private PatternMaker patternMaker;
    private List<Pattern> subPatternList;

    public Pattern(PatternMaker patternMaker, List<Pattern> subPatternList) {
        return;
    }
}
