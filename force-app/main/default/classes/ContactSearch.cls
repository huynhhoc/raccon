public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode){
        List<Contact> contactList=null;
        contactList=[SELECT Id, Name FROM Contact WHERE (LastName=:lastName OR MailingPostalCode=:mailingPostalCode)];     
        return contactList;
    }
}