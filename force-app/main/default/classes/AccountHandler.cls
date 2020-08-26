public class AccountHandler {
    public static Account insertNewAccount( String accountName){
        try{
           Account acct = new Account(Name=accountName);
           insert acct;
           return acct;
        }catch(DmlException dmlExc){
            System.debug('A DML exception has occurred: ' + dmlExc.getMessage());
            return null;
        }
       
    }
}