public class AJAXCall {
    public static void GetAJAXCall()
    {
        Http ht = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://countriesnow.space/api/v0.1/countries/population/cities');
        req.setMethod('GET');
        HttpResponse resp = ht.send(req); 
        if(resp.getStatusCode() == 200)
        {
            MAP<string,object> responseJson = (Map<string,Object>)JSON.deserializeUntyped(resp.getBody());
            System.debug(responseJson);
            List<object> lst=(List<object>) responseJson.get('data');
            System.debug(lst);
            for(Object obj:lst)
            {
                Map<string,Object> mMap = (Map<string,Object>)obj;
                system.debug(mMap);
            }
        }
    }
}