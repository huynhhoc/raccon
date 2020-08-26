public with sharing class HelperCountrySync {
    public static list<Country__c> insertNew(){
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;alpha3Code;capital;region;subregion;regionalBlocs'); 
        httpReq.setMethod('GET');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setTimeout(1000);
        System.debug('Http Requset=' + httpReq);

        //-- 2. sending the httpRequest and getting the httpResponse
        Http http = new Http();
        HttpResponse httpRes;

        try {
            httpRes = http.send(httpReq);
            System.debug('body: ' + httpRes.getBody());
        } catch (System.CalloutException e) {
            System.debug(e.getMessage());
        }
        list<Country__c> countryList = new list<Country__c>();
        try{
            List<Object> results = (List<Object>)JSON.deserializeUntyped(httpRes.getBody());
            //Create Countries in bulk.
            for(Object key: results) {
                Map<String, Object> rules0 = (Map<String, Object>)key;
                List<Object> data = (List<Object>)JSON.deserializeUntyped(JSON.serialize(rules0.get('regionalBlocs')));
                Country__c anCountry= new Country__c();
                if (data.size() > 0){
                   // Map<String,Object> mapAcronym = (Map<String,Object>)data[0];
                    anCountry.RegionalBlocs__c  = ((Map<String,Object>)data[0]).get('acronym').toString();
                }
                anCountry.Name__c  = rules0.get('name').toString();
                anCountry.Alpha2Code__c  = rules0.get('alpha2Code').toString();
                anCountry.Alpha3Code__c  = rules0.get('alpha3Code').toString();
                anCountry.Capital__c  = rules0.get('capital').toString();
                anCountry.Region__c  = rules0.get('region').toString();
                anCountry.Subregion__c  = rules0.get('subregion').toString();
                countryList.add(anCountry);
                System.debug('Http Response country = '+ anCountry);
            }
        }catch(NullPointerException e){
            System.debug(e.getMessage());
        }
        return countryList;
    }
    public static Boolean isChangedCountry (Lead newLead, Lead oldLead){
        if (oldLead.Country__c == null){
            if (newLead.Country__c !=null){
                return true;
            }
        }else if (newLead.Country__c == null || oldLead.Country__c != newLead.Country__c){
            return true;
        }
        return false;
    }
}