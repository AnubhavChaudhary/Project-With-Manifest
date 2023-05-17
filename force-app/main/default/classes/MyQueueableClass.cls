public class MyQueueableClass implements Queueable {
    public static void execute(QueueableContext queCon)
    {
        System.debug('I am called');
    }

}