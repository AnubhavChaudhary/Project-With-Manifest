Global class EqualDevideAccountBatch implements Database.Batchable<sObject>,Database.Stateful 
{
    private Set<Id> UserChecked;
    private Map<Id,User> Map1;
    private Map<Id,User> Map2;
    private Map<Id,User> Map3;
    public List<Account> Start(Database.BatchableContext btch)
    {
        UserChecked = new Set<Id>();
        Map1 = new Map<Id,User>();
        Map2 = new Map<Id,User>();
        Map3 = new Map<Id,User>();
        List<Account> acc = [Select Id, Phone, Name from Account WHERE Owner.Alias='AChau' and CreatedDate=today];
        return acc;
    }
    public void Execute(Database.BatchableContext btch, List<Account> acc)
    {
        System.debug(acc);
        string RoleId = '00E5g000000QUPBEA4';
        System.debug(UserChecked);
        if(Map2.IsEmpty())
        {
            System.debug('Map2 is empty');
        	Map2 = new Map<Id,User>([Select Id, Name,Capacity__C,IsActive from User where UserRoleId =: RoleId and IsActive=true]);
        }
    }
    public void Finish(Database.BatchableContext btch)
    {
        system.debug('These Users were used'+UserChecked);
        UserChecked = new Set<Id>();
        Map1 = new Map<Id,User>();
        Map2 = new Map<Id,User>();
        Map3 = new Map<Id,User>();
    }
}