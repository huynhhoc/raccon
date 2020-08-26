public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(String str){
        List<List< SObject>> searchList = [FIND: str IN ALL FIELDS  RETURNING Contact(LastName),Lead(LastName, Company)];
        return searchList;
    }
}