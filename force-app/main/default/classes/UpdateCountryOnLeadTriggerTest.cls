@isTest
public with sharing class UpdateCountryOnLeadTriggerTest {
    @TestSetup
    static void setup() {
        Country__c country1 = new Country__c(Name__c = 'Country1',Alpha2Code__c='A1', Alpha3Code__c='AB1');
        Country__c country2 = new Country__c(Name__c = 'Country2',Alpha2Code__c='A2', Alpha3Code__c='AB2');
        List<Country__c> countries = new List<Country__c>();
        countries.add(country1);
        countries.add(country2);
        try{
            insert countries;
        }catch(DmlException e){
            System.debug('An unexpected error has occurred (country): ' + e.getMessage());
        }
        //Insert Lead
        try{
            Lead anLead = new Lead(lastname='test', company='test',Status = 'Open');
            insert anLead;
        }catch(DmlException e){
            System.debug('An unexpected error has occurred (lead): ' + e.getMessage());
        }
        //Query
        List<Country__c> countries2=[select Id, Name__c,Alpha2Code__c, Alpha3Code__c, Capital__c,Region__c, Subregion__c,RegionalBlocs__c
                     from Country__c];
        System.debug('countries1 : ' + countries2);
    }
    @isTest
    static void testUpdateCountryonLead() {
        //Query
        List<Country__c> countries2=[select Id, Name__c,Alpha2Code__c, Alpha3Code__c, Capital__c,Region__c, Subregion__c,RegionalBlocs__c
                     from Country__c];
        System.debug('countries2 : ' + countries2);
        if (!countries2.isEmpty()){
            try{
                List<Lead> leads=[SELECT Id, lastname, company, status, Country__c, InformationCountry__c from Lead limit 1];
                List<Database.SaveResult> results = new List<Database.SaveResult>();
                if (!leads.isEmpty()){
                    Test.startTest();
                    leads[0].Country__c = countries2[0].Id;
                    results.add(Database.update(leads[0], true));
                    if (countries2.size()>1){
                        leads[0].Country__c = countries2[1].Id;
                        results.add(Database.update(leads[0], true));
                    }
                    Test.stopTest();
                    for (Database.SaveResult result : results){
                        System.assertEquals(true, result.isSuccess(), 'pass');
                    }
                }
            }catch(DmlException e){
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
    }
}