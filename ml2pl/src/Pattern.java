import javax.swing.tree.*;

/**
 * Created by xiaohong on 2/2/17.
 */
public class Pattern{
    private DefaultTreeModel pattern;

    /**
     * Creates a pattern which is a variable named @varName in sort @s.
     * @param varName
     * @param s
     */
    public Pattern(String varName, Sort s){
        DefaultMutableTreeNode root = new DefaultMutableTreeNode(varName, false);
        this.pattern = new DefaultTreeModel(root, true);
    }


}
