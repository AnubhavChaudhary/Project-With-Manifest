public with sharing class showDatainGrid {
    public showDatainGrid() {

    }
    @AuraEnabled
    public static List<Contact> GetAccounts(){
        try {
            return [Select id,name,phone,email from Contact order by createdDate desc];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Contact> filterContacts(string Name){
        try {
            if(string.isBlank(Name))
            {
                return [Select id,name,phone,email from Contact];
            }
            else {
                string likeName = '%'+Name+'%';
                return [Select id,name,phone,email from Contact where name like :likeName];
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // @AuraEnabled
    // public static List<Contact> deleteContact(string Id){
    //     try {
    //         delete 
    //     } catch (Exception e) {
    //         throw new AuraHandledException(e.getMessage());
    //     }
    // }

    @AuraEnabled
    public static integer addDigits(integer firstDigit,integer secondDigit){
        try {
            return (firstDigit+secondDigit);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
