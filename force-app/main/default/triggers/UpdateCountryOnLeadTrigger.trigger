trigger UpdateCountryOnLeadTrigger on Lead (before insert, before update) {
    for (Lead newLead : Trigger.New){
        if (Trigger.isUpdate){
            Lead oldLead = Trigger.oldMap.get(newLead.ID);
            //if (newLead.InformationCountry__c != oldLead.InformationCountry__c){
            if (HelperCountrySync.isChangedCountry(newLead, oldLead)){
                newLead.ChangedCountryInformation__c = System.Label.ChangedCountryInformation + ' ' + Datetime.now();
            }
        }
    }
}