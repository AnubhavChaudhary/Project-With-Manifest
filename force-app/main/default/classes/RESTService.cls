@RestResource(UrlMapping='/AnubhavServices/*')
global class RESTService {
    @HttpGET
    global static List<General__C> GetCases()
    {
        List<General__C> gen = [Select Maths__C,Science__C,Name,Last_Name__C,Gender__C from General__C];
        return gen;
    }
    @HttpPost
    global static string PostClass()
    {
        string KeyName; 
        string KeyValue;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string str = req.requestBody.toString();
        JSONParser parsed = JSON.createParser(str);
        While(parsed.nextToken()!=Null)
        {
            if(parsed.getCurrentToken() != JSONToken.END_OBJECT)
            {
                KeyName = parsed.getCurrentName();
                //if(KeyName == 'First Name')
                //{
                //    KeyValue = parsed.getText();
                //}
            }
        }                   
        KeyValue = parsed.getText();
        Account acc = new Account();
        acc.Name = KeyValue;
        insert acc;
        return acc.Id;
    }
}