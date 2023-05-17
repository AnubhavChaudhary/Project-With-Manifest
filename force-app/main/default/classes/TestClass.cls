public class TestClass {
    public static void TestClassMethod()
    {
        //Date today = Date.today();
        //String todayDate = String.valueOf(system.today());
        List<Account> acc = [Select Id, Phone, Name, CreatedDate from Account WHERE CreatedDate=today];
        
        for(Account art:acc)
        {
            //System.debug(art);
        }
        string RoleId = '00E5g000000QUPBEA4';
        //List<User> lstUser = [Select Id, Name,Capacity__C,IsActive from User where UserRoleId =: RoleId and IsActive=true];
        List<User> lstUser = [Select Id, Name,Capacity__C,IsActive from User where UserRoleId =: RoleId and IsActive=true];
        //List<AggregateResult> lstUser1 = [Select OwnerID,Owner.Name, Count(Name) from Account group by OwnerID , Owner.Name];
        //Map<Id,Integer> testMap = new Map<Id,Integer>();
        //for(AggregateResult agg:lstUser1)
        //{
        //    Map.put(agg.get('OwnerID'),agg.get('Name'));
        //    System.debug(agg);
        //}
        System.debug(lstUser);
        //Integer chkCount = [Select Count() from Account];
        //System.debug(chkCount);
        //List<Account> lstAcc = new List<Account>();
        //for(User us:lstUser)
        //{
        //    if(us.Id=='0055g000008wJLoAAM')
        //    {
        //        for(Account ac:acc)
        //        {
        //            ac.ownerId=us.Id;
        //            lstAcc.add(ac);
        //            //update ac;
        //			System.debug(us.Id+''+us.Name+''+us.Capacity__c);
        //        }
        //    }
        //}
        //System.debug(lstAcc);
        //update lstAcc;
    }
}