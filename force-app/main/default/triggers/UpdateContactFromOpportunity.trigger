trigger UpdateContactFromOpportunity on Opportunity (after update) {
    Map<Id,Opportunity> mapOppo = new Map<Id,Opportunity>(trigger.newMap);
    if(trigger.new[0].StageName == 'Closed Won')
    {
        Id OpportunityId = trigger.new[0].Id;
        List<Contact> lstContact = [Select Id, Phone from Contact where AccountId =: mapOppo.get(OpportunityId).AccountId];
        List<Contact> lstUpdateContact = new List<Contact>();
        for(Contact con:lstContact)
        {
            con.Phone = '7845';
            lstUpdateContact.add(con);
        }
        update lstUpdateContact;
    }
}