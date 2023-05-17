public class InsertDatainAccount {
    public static void InsertData()
    {
        List<Account> accountList = new List<Account>();
        for(integer i=40;i<80;i++)
        {
            Account acc = new Account();
            acc.Name = 'Account'+i;
            acc.Phone = '123'+i;
            accountList.add(acc);
        }
        insert accountList;
    }

}