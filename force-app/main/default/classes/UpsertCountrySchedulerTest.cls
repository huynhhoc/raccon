@isTest
public with sharing class UpsertCountrySchedulerTest {
    @TestSetup
    static void setup() {
        Country__c country = new Country__c();
        try{
        country.Name__c = 'South Asian Association for Regional Cooperation';
        country.Alpha2Code__c='AF';
        country.Alpha3Code__c='AFG';
        country.Capital__c='Kabul';
        country.Region__c='Asia';
        country.Subregion__c='Southern Asia';
        country.RegionalBlocs__c='SAARC';
        insert country;
        }catch(DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    static testmethod void testUpsertCountry(){
        Test.startTest();
            String body = '[{"regionalBlocs":[{"acronym":"SAARC","name":"South Asian Association for Regional Cooperation","otherAcronyms":[],"otherNames":[]}],"name":"Afghanistan","alpha2Code":"AF","alpha3Code":"AFG","capital":"Kabul","region":"Asia","subregion":"Southern Asia"}]';
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(body));
            // Schedule the test job
            String CRON_EXP = '0 0 0 3 9 ? 2022';
            String jobId = System.schedule('testUpsertCountryScheduler',CRON_EXP, new UpsertCountryScheduler());
            // Get the information from the CronTrigger API object
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                NextFireTime
                FROM CronTrigger WHERE id = :jobId];
            Test.stopTest();
            // Verify the expressions are the same
            System.assertEquals(CRON_EXP, ct.CronExpression);

            // Verify the job has not run
            System.assertEquals(0, ct.TimesTriggered);

            // Verify the next time the job will run
            System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        //Test.stopTest();
    }
}