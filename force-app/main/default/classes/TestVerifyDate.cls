@isTest
public class TestVerifyDate {
    @isTest static void VerifyCheckDates()
    {
        Date dt1 = system.today();
        Date dt2 = system.today();
        VerifyDate.CheckDates(dt1,dt2);
    }
}
