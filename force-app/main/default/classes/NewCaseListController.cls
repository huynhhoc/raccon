public class NewCaseListController {
    public list<case> GetNewCases(){
        list<case> newcase = [Select Id,CaseNumber from case where status='New'];
        return newcase;
    }
}