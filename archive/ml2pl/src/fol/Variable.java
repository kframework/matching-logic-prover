package fol;

/**
 * Created by Xiaohong on 2/8/17.
 */
public class Variable {
    private final String name;

    public Variable(String name) {
        this.name = name;
    }

    private static int freshVariableCounter = 0;
    public static Variable generateFreshVariable(){
        freshVariableCounter++;
        return new Variable('$'+ String.valueOf(freshVariableCounter));
    }

    @Override
    public String toString() {
        return name;
    }
}
