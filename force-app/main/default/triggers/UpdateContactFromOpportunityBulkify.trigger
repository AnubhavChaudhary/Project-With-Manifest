trigger UpdateContactFromOpportunityBulkify on Opportunity (after update) {
    Map<Id,Opportunity> mapOppo = new Map<Id,Opportunity>(trigger.newMap);
    Set<Id> AccountIds = new Set<ID>();
    List<Contact> lstUpdateContact = new List<Contact>();
    for(Opportunity opp:mapOppo.values())
    {
        if(opp.StageName == 'Closed Won')
        {
        	AccountIds.add(opp.AccountId);
        }
    }
    if(AccountIds.size() > 0)
    {
        List<ID> lstAccountIds = new List<Id>(AccountIds);
        List<Contact> lstContact = [Select Id, Phone, AccountId, Amount__C from Contact where AccountId in: lstAccountIds];
    	List<Account> lstAvg = [Select Id, ChildAmtAvg__c from Account where Id in: lstAccountIds];
        for(integer i=0; i<lstAccountIds.size(); i++)
        {
            Decimal ChildAmount = 0;
            Integer Count = 0;
            Decimal Avg;    
            for(Contact con:lstContact)
            {
                if(con.AccountId == lstAccountIds[i])
                {
                    ChildAmount = ChildAmount + con.Amount__c;
                    Count = Count + 1;
                    Avg = ChildAmount/Count;
                }
            }
            for(integer j=0; j<lstAvg.size(); j++)
            {
                if(lstAvg[j].Id == lstAccountIds[i])
                {
                    lstAvg[j].ChildAmtAvg__c = Avg;
                    break;
                }
            }
        }
        update lstAvg;
    }
}