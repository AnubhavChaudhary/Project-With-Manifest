public with sharing class CreateCases {
    @AuraEnabled
    public static string CreateCases(string Priority, string Subject, string Description, string Cc){
        try {
            Case newCase = new Case();
            newCase.Priority = Priority;
            newCase.Subject = Subject;
            newCase.Description = Description;
            //newCase.Cc__c = Cc;
            insert newCase;
            return newCase.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
