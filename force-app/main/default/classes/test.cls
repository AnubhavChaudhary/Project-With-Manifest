public class test {
    public static void test1(){
        string UpdatedOppName = 'Opp1';
        List<Opportunity> opportunityList = Database.query('Select name,stagename,account.name from opportunity where name=:UpdatedOppName');
        string parentAccount = opportunityList[0].account.name;
        List<Account> accounts = Database.query('Select name,phone,(Select Name, StageName from Opportunities) from Account where name =:parentAccount');
        
        for(Account acc: accounts)
        {
            for(Opportunity opp: acc.Opportunities)
            {
                system.debug(opp);
            }
        }
        List<General__c> general = [select name, (select Full_Name__C from personal__r) from General__c];
        List<personal__c> personal= new List<personal__c>();
        for(General__c gen: general)
        {
            system.debug(gen);
            system.debug(gen.personal__r);
            for(Personal__c personalObj:gen.personal__r)
            {
                personal.add(personalObj);
            }
        }
        for(personal__c per:personal)
        {
            system.debug(per);
        }
    }
}