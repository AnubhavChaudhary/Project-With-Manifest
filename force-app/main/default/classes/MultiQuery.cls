public class MultiQuery {
    public static void ChildToParent()
    {
        //List<Contact> contact = [select name, Account.name from Contact where name='Anubhav Chaudhary'];
        //system.debug(contact);
        
        List<General__c> general = [select name, (select Full_Name__C from personal__r) from General__c];
        system.debug(general);
    }

}