trigger OpportnityTriggers on Opportunity (before insert, before update) {
    if(trigger.isUpdate)
    {
        Map<Id,Opportunity> newMapOpp = trigger.newMap;
        Map<Id,Opportunity> oldMapOpp = trigger.oldMap;
        Set<Id> sets = oldMapOpp.keySet();
        for(Id ids:sets)
        {
            Opportunity newOpp = newMapOpp.get(ids);
            Opportunity oldOpp = oldMapOpp.get(ids);
            if(newOpp.stageName == 'Closed Won' && oldOpp.stageName != 'Closed Won')
            {
                newOpp.CloseDate = System.today();
                newOpp.Type = 'New Customer';
                for(Account acc:[Select phone,id from Account where id =: newOpp.AccountId])
                {
                    acc.phone = '454545';
                }
            }
        }
    }
}