public class ChildToParent {
    public static void Test(){
        Personal__C con = [Select name, General__r.name,General__r.email__c from Personal__C where name='6543'];
        system.debug(con);
    }
}