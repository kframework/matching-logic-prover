public class Main {

    public static void main(String[] args) {
        Configuration cfg1 = new Configuration("TOP");
        cfg1.addSubConfiguration(new Configuration("Thread"));
        cfg1.addSubConfiguration(new Configuration("Output"));
        cfg1.addSubConfiguration(new Configuration("Input"));

        Configuration cfg2 = new Configuration("TOP");
        cfg2.addSubConfiguration(new Configuration("Thread"));
        cfg2.addSubConfiguration(new Configuration("Output"));
        cfg2.addSubConfiguration(new Configuration("Input"));
        cfg1.addSubConfiguration(new Configuration("Env"));

        System.out.print(cfg1.equals(cfg2));
    }

}
