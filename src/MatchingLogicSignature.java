import java.util.Arrays;
import java.util.Dictionary;

/**
 * Created by Xiaohong on 10/25/16.
 */

public class MatchingLogicSignature {
    private String[] sorts;

    /**
     * symbolTable associates each sort in sorts a type, i.e., a tuple of
     * sorts. The tuple is implemented by an array. The tuple contains at
     * least one element for the sort of the "returning" element of the
     * symbol.
     * For example:
     *   symbol "add" has type ["Int","Int","Int"]
     *   symbol "ge"  has type ["Int","Int","Bool"]
     */
    private Dictionary<String, String[]> symbolTable;

    /**
     * Check sanity of a MatchingLogicSignature. Whenever there is
     * a change of sorts or symbolTable, isSane() has to be called
     * in order to assure the sanity and validity of the signature.
     * Sanity checking includes:
     *   Each sort has a unique name
     *   Each symbol has a unique name
     *   Each symbol has a valid type. Refer to symbolTable for
     *   what it means by a valid type.
     * @return true if the signature is a sane and consistent one.
     */
    private boolean isSane(){
        // TODO: 10/25/16 Implement this method based on the above spec.
        return true;
    }

    /**
     * Create a matching logic signature with the given @sortNames
     * as names of its sorts. The symbol table is empty, and will
     * be fill in with other methods after creation.
     * @param sortNames should contain at least one sort name.
     */
    public MatchingLogicSignature(String... sortNames){
        /**
         * I don't know whether it is a safe practice.
         * It works for now but might be dangerous.
         * Xiaohong
         */
        sorts = sortNames;

        if (!isSane()) {
            try {
                throw new Exception("Insane Matching Logic Signature.\n");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public String toString(){
        return Arrays.toString(sorts);
    }


}
