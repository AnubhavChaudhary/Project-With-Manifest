public class CreateBulkAccountRecords {
    public static void CreateRecords()
    {
        List<Account> lstAcc = new List<Account>();
        for(integer i=0; i<80; i++)
        {
            Account acc = new Account();
            acc.Name='Today14Acc'+i;
            acc.Phone='1245'+i;
            lstAcc.add(acc);
        }
        insert lstAcc;
    }
    
    public static void DeleteRecords()
    {
        List<Account> lstAcc = [Select Id from Account where createdDate=today];
        //List<Account> lstAcc = [Select Id from Account where Name like '%Account1%'];
        delete lstAcc;
    }
}