public class Main {

    public static void main(String[] args) {
        Configuration premise = new Configuration("TOP");
        Configuration conclusion = new Configuration("TOP");
        System.out.print(premise.toString() + '\n');
        if (MatchImplicator.matchImplies(premise, conclusion))
            System.out.print("implies\n");
        else
            System.out.print("does not imply\n");
        System.out.print(conclusion.toString() + '\n');
    }

}
