public class HelperClass {
    public static void beforInsertMethod(List<General__C> generalList){
        system.debug('Insert');
        for(General__C gen: generalList)
        {
            gen.Maths__c = 30;
        }
    }
    public static void beforeUpdateMethod(List<General__C> generalList){
        system.debug('Update');
        for(General__C gen: generalList)
        {
            gen.Maths__c = 60;
        }
    }

}