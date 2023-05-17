public class FutureMethdClass {
    public FutureMethdClass()
    {
        NormalMethod();
        FutureMethod();
    }
    public static void NormalMethod()
    {
        system.debug('I will be called saperately');
    }
    
    @future
    public static void FutureMethod()
    {
        system.debug('I will be called from Future');
    }

}