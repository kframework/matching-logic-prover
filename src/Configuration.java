import jdk.nashorn.internal.runtime.regexp.joni.Config;

import java.util.*;
import java.util.Collections;

/**
 * Created by shell on 10/27/16.
 */
public class Configuration{
    private String constructor = null;
    private List<Configuration> subConfigurations = new ArrayList<>();

    public Configuration(String constructor) {
        this.constructor = constructor;
    }

    public void addSubConfiguration(Configuration subConfiguration){
        subConfigurations.add(subConfiguration);
    }

    public String getConstructor() {
        return constructor;
    }
    public List<Configuration> getSubConfigurations() {
        return subConfigurations;
    }

    /**
     * Compares the name of the top constructors of two configurations.
     * If the names are the same then return 0. Otherwise, return 1 or -1.
     */
    public class ConstructorNameComparator implements Comparator<Configuration> {
        @Override
        public int compare(Configuration cfg1, Configuration cfg2) {
            return cfg1.getConstructor().compareTo(cfg2.getConstructor());
        }
    }

    /**
     * Sorts all subconfigurations only by their names, not taking their contents into account.
     */
    public void sortSubConfigurationsByTheirNames(){
        Collections.sort(subConfigurations, new ConstructorNameComparator());
    }

    /**
     * Check whether two cfgs are the same in terms of their structures.
     */
    public boolean equals(Configuration otherConfiguration){
        /**
         * This is a very complex function. I would like to write as many comments as
         * I can, so that future readers can spend less time understand this function.
         *
         * Firstly, let us recall that a configuration has a constructor, or called its
         * label, and contents, or called its subconfigurations. Suppose there are two
         * configurations C and D, whose subconfigurations are c1,...,cn and d1,...,dm
         * respectively. We say C equals D, if
         *   (1) C.constructor = D.constructor
         *   (2) n = m
         *   (3) there exists a permutation i1,...,in of 1,...,n such that
         *       c1 = d_i1, c2 = d_i2, ..., cn = d_in
         *
         * The first two conditions are easy to check as follows.
         */
        if(!this.constructor.equals(otherConfiguration.constructor))
            return false;
        if(this.subConfigurations.size() != otherConfiguration.subConfigurations.size())
            return false;

        /**
         * Now we know that the two configurations we want to compare have the same constructor
         * and the same number of sub configurations. In order to check the equivalence further,
         * we have to find a permutation i1,...,in such that the above (3) holds.
         *
         * We try to find such a permutation by backtracking. Please notice that i1,...,in will be
         * implemented with an array int[n] i, with i[0],...,i[n-1] contains the i1,...,in we
         * mentioned above.
         *
         * We need a pointer to denote where we have reached during backtracking. We call such a
         * pointer head, which holds an index in [0, n-1]. The meaning of head is illustrated by
         * the follower example. Let's say head = 3, then it means that
         *      c_0 = d_i[0]
         *      c_1 = d_i[1]
         *      c_2 = d_i[2]
         *      c_3 = d_i[3]
         *  Whenever we have head = n-1, we know that we find the permutation we look for, and C = D.
         *  Whenever we have head < n-1, we know that we are still on the way of finding the right one.
         *  Let's say head = 3 < n-1, then we are trying to find i[4] such that c_4 = d_i[4]. We need
         *  a function called findNext(i, head) to do this thing. If such an index exists, we put that in i[4],
         *  and move head from 3 to 4. And then we repeat the process until either we reach head = n-1, or
         *  we end with head is, say, 4, which is less than n-1, and there does not exists an index j that is
         *  different from i[0...4] such that c_5 = d_j. When this happens, it means that we made some mistakes
         *  in assigning indexes for i[0...4] and we need to change them. We know there does not exist any
         *  valid index for i[5] because findNext(i, head) returns a zero. In this case, we decrease head by 1,
         *  and call findNext(i, head) again. In our case, it is findNext(i, 4), which means that we want to
         *  find some index for i[4]. findNext() knows that we have reached i[4] before, because there is
         *  still some index left there. So findNext will return the smallest valid index for i[4] that is bigger
         *  than the one that was in i[4]. When it finds one, we rewrite i[4] and move head one place ahead. When
         *  it fails, we decrease head by 1 and repeat.
         *  findNext(i, head) tries to look for a valid index for i[head+1], and it tries to find the smallest valid
         *  index that is bigger than the one that is currently in i[head+1]. Initially, i[0...n-1] is all zeros, so
         *  it finds the smallest one. Otherwise it always looks for "the next one".
         *  Therefore, it is very important to clean up the index array when backtracking. Suppose we are now trying
         *  with head = 4 and fail to find an index for i[5]. Before we backtracking, we need to reset i[5] to zero,
         *  otherwise the information left in i[5] will interfere with the continuing searching.
         *  */



        return true;
    }

    /**
     * Transform the object to Stirng object.
     * This method is automatically generated by IntelliJ.
     * @return A String object that represents the configuration.
     */
    @Override
    public String toString() {
        return "Configuration{" +
                "constructor='" + constructor + '\'' +
                ", subConfigurations=" + subConfigurations +
                '}';
    }
}
