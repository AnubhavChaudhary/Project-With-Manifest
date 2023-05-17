public class GetObjectRecord {
    public static void getRecord(string name){
        List<light_object__c> general= [Select ID,Name from light_object__c];
        //for(light_object__c gen:general){
         //   system.debug(gen);
        //}
        List<light_object__c> filteredList= Database.query('Select ID,First_Name__c from light_object__c where First_Name__c like \'%' + name + '%\'');
        system.debug(filteredList);
    }
}