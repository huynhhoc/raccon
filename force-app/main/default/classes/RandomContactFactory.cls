public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberofcontacts, string l_name){
        List<Contact> cnts = new List<Contact>();
        for(integer i=0; i<numberofcontacts; i++){
            contact cnts1=New contact();
            string Name='Test'+i;                
            cnts1.FirstName=Name;//add the content of name variable to First Name field of contact object
            cnts1.LastName=l_name;//add the content of name variable to LastName field of contact object
            cnts.Add(cnts1);//add to the list collection, Contact                                  
        }
        return cnts;//returning the list to the called method 
    }
}