import java.util.Optional;

/**
 * Created by xiaohong on 2/8/17.
 */
public abstract class PatternMaker {
    private Optional<Integer> expectedNumberOfArity;
    private boolean isBinder;

    public abstract boolean hasFixedNumberOfArity();
    public abstract boolean isBinder();
    public abstract boolean isCommunitive();
    public abstract boolean isAssociate();

}
