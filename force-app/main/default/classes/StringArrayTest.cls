public class StringArrayTest {
    public static String[] generateStringArray(Integer len){
        String[] myarr = new String[len];
        for(integer n=0;n<len;n++){
            myarr[n] ='Test ' + n;
            system.debug(myarr[n]);
        }
        return (myarr);
    }

}