trigger GetOpportunity on Opportunity (after update) 
{
    string UpdatedOppName = '';
    List<Opportunity> tobeUpdated = new List<Opportunity>();
    if(trigger.isUpdate)
    {
        UpdatedOppName = trigger.new[0].name;
        //for(Opportunity opp:trigger.new)
        //{
        //    UpdatedOppName = opp.name;
        //}
        List<Opportunity> opportunityList = [Select name,stagename,account.name from opportunity where name=:UpdatedOppName];
        string parentAccount = opportunityList[0].account.name;
        List<Account> accounts = Database.query('Select name,phone,(Select Name, StageName from Opportunities) from Account where name =:parentAccount');
        
        
        for(Account acc: accounts)
        {
            for(Opportunity opp: acc.Opportunities)
            {
                if(opp.Name != UpdatedOppName)
                {
                if(opp.StageName != 'Closed Won')
                {
                    opp.StageName = opportunityList[0].stagename;
                    tobeUpdated.add(opp);
                }
                }
            }
        }
        
    }
    update tobeUpdated;

}