@IsTest
public class AccountTriggerTest {
    @isTest static void TestUpdateAccount() {
        //Test Data setup
        try{
            Account acct = new Account(Name='Test Account');
            acct.Match_Billing_Address__c = false;
            acct.ShippingPostalCode = '1';
            acct.BillingPostalCode = '2';
            insert acct;
        }catch(DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        //Query
        List<Account> accounts=[select Id, Name, Match_Billing_Address__c, ShippingPostalCode, BillingPostalCode
                                from Account limit 1];
        if (!accounts.isEmpty()){
            try{
                Account account = accounts[0];
                account.Match_Billing_Address__c = true;
                
                // Perform test
                Test.startTest();
                Database.SaveResult result = Database.update(account, false);
                System.assertEquals(true, result.isSuccess(), 'pass');

                Test.stopTest();
                
            }catch(DmlException e){
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
    }
}