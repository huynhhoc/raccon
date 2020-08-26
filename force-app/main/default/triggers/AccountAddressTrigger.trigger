trigger AccountAddressTrigger on Account (before insert, before update) {
    for (Account acc : Trigger.New){
        Account oldAccount = Trigger.oldMap.get(acc.ID);
        if (acc.Match_Billing_Address__c == true){
            acc.ShippingPostalCode = acc.BillingPostalCode;
            System.debug('test ket qua run trigger account = ' + acc.Name);
            System.debug('test ket qua SPC new account = ' + acc.ShippingPostalCode);
            System.debug('test ket qua BPC old account = ' + oldAccount.ShippingPostalCode);
        }
    }
}