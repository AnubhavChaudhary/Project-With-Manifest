public class CallSalesforceRest {
    public static void GetGeneralTableData()
    {
        Http ht = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:SecretCred/services/apexrest/AnubhavServices');
        req.setMethod('GET');
        HttpResponse res = ht.send(req);
        system.debug(res.getStatusCode());
    }

}