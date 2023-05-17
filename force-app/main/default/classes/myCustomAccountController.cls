public class myCustomAccountController {
    public List<Account> accountList {get;set;}
    public myCustomAccountController(){
        accountList = [Select Id,Name from Account limit 10];
    }

}