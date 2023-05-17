global class BatchClass implements Database.Batchable<sObject>, Schedulable
{
    Global Database.QueryLocator Start(Database.BatchableContext btch)
    {
        return Database.getQueryLocator([Select Science__c from General__C]);
    }
    Global void Execute(Database.BatchableContext btch, List<General__C> lstGen)
    {
        for(General__C gen: lstGen)
        {
            gen.Science__c = 87;
        }
        update(lstGen);
    }
    Global void Finish(Database.BatchableContext btch)
    {
        
    }
    Global void execute(SchedulableContext sc)
    {
        BatchClass btc =  new BatchClass();
        Database.executeBatch(btc);
    }
}