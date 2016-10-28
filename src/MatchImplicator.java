import java.util.List;

/**
 * Created by shell on 10/27/16.
 */
public class MatchImplicator {
    static public boolean matchImplies(Configuration premise, Configuration conclusion){
        if (premise.getConstructor() != conclusion.getConstructor())
            return false;

        List<Configuration> subConfigurationsOfPremise = premise.getSubConfigurations();
        List<Configuration> subConfigurationsOfConclusion = conclusion.getSubConfigurations();

        if (subConfigurationsOfPremise.size() != subConfigurationsOfConclusion.size())
            return false;

        for(int i = 0; i < subConfigurationsOfPremise.size(); i++){
            if (!matchImplies(subConfigurationsOfPremise.get(i), subConfigurationsOfConclusion.get(i)))
                return false;
        }

        return true;
    }
}
