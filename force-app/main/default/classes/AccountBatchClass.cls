Global class AccountBatchClass implements Database.Batchable<sObject>,Database.Stateful
{
    private Set<Id> UserChecked;
    private Map<Id,Integer> CurrentUserIdAndCount;
    public List<Account> Start(Database.BatchableContext btch)
    {
        UserChecked = new Set<Id>();
        CurrentUserIdAndCount = new Map<Id,Integer>();
        List<Account> acc = [Select Id, Phone, Name from Account WHERE Owner.Alias='AChau' and CreatedDate=today];
        return acc;
    }
    public void Execute(Database.BatchableContext btch, List<Account> acc)
    {
        System.debug(acc);
        string RoleId = '00E5g000000QUPBEA4';
        List<User> lstUser;
        System.debug(UserChecked);
        if (!UserChecked.isEmpty())
        {
            System.debug('Set is not empty');
            lstUser = [Select Id, Name,Capacity__C,IsActive from User where UserRoleId =: RoleId and IsActive=true and ID not in:UserChecked ];
        }
        else
        {
            System.debug('Set is empty');
        	lstUser = [Select Id, Name,Capacity__C,IsActive from User where UserRoleId =: RoleId and IsActive=true ];
        }
        System.debug(lstUser);
        List<Account> lstUpdateAccount = new List<Account>();
        for(User us: lstUser)
        {
            if(!UserChecked.contains(us.Id))
            {
                Integer count = [Select Count() from Account where Owner.Id=:us.Id and createddate=today];
                System.debug('Owner is '+us.Name+' and Capacity is '+us.Capacity__c +' and count is '+count);
                if(us.Capacity__c > count)
                {
                    System.debug('Capacity is more');
                    for(Account acco: acc)
                    {
                        acco.OwnerId = us.Id;
                        lstUpdateAccount.add(acco);
                        CurrentUserIdAndCount.put(us.Id,acc.size());
                        System.debug(acco);
                    }
                }
                else if(us.Capacity__c <= count)
                {
                    UserChecked.add(us.Id);
                    System.debug('UserAdded');
                }
                break;
            }
        }
        System.debug(lstUpdateAccount);
        update lstUpdateAccount;
    }
    public void Finish(Database.BatchableContext btch)
    {
        system.debug('These Users were used'+UserChecked);
        UserChecked = new Set<Id>();
        CurrentUserIdAndCount = new Map<Id,Integer>();
    }
}