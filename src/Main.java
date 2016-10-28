public class Main {

    public static void main(String[] args) {
        Configuration premise = new Configuration("TOP");
        premise.addSubConfiguration(new Configuration("Thread"));
        premise.addSubConfiguration(new Configuration("Output"));
        premise.addSubConfiguration(new Configuration("Input"));

        System.out.print(premise.toString() + '\n');
        premise.sortSubConfigurationsByTheirNames();
        System.out.print(premise.toString() + '\n');
    }

}
