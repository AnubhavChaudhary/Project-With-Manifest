public class HelloWorld {
    public static General__c hiWorld(){
        system.debug('Hi All');
        integer i;
        i=10;
        system.debug(i+5);
        decimal j=5.78;
        system.debug(j);
        system.debug(j.round());
        double k= 5.78;
        system.debug(k);
        system.debug(k.round());
        Date dt= Date.newInstance(2021, 07, 02);
        Time tm= Time.newInstance(1,30,45,12);
        Datetime dtm=DateTime.newInstance(dt, tm);
        system.debug(dt);
        system.debug(tm);
        system.debug(dtm);
        General__c gen= new General__c();
        gen.Name='Object Val';
        gen.Last_Name__c='Last Name';
        system.debug(gen);
        return gen;
    
    }
}