public class SOSL {
    public static void sosl(){
        List<List<sObject>> l1= [Find 'John' returning Account,Contact];
        List<List<sobject>> l2= [Find 'John' returning Account(Name,Rating),Contact(Name,Phone)];
        List<Account> accountList = l1[0];
        List<Account> accountList1 = l2[0];
        system.debug(accountList);
        system.debug(accountList1);
        List<Contact> ContactList = l1[1];
        List<Contact> ContactList1 = l2[1];
        system.debug(ContactList);
        system.debug(ContactList1);
    }
}