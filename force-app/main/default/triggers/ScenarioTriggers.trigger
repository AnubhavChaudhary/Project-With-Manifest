trigger ScenarioTriggers on Account (before insert, after insert) {
    if(trigger.isAfter)
    {
        List<Contact> lstCon = new List<Contact>();
        for(Account acc: trigger.new)
        {
            if(acc.Industry == 'Banking')
            {
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = acc.Name;
                con.Phone = acc.Phone;
                lstCon.add(con);
            }
        }
        insert lstCon;
    }
}