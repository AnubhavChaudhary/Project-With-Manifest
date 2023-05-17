trigger FirstTrigger on General__c (before insert, before update) {
    if(Trigger.isInsert)
    {
        HelperClass.beforInsertMethod(Trigger.new);
    }
    else {
        if(Trigger.isUpdate){
        HelperClass.beforeUpdateMethod(Trigger.new);
        }
    }
}