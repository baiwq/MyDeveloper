public class Acc {
	public Account acct{get;set;}
    public Acc(){
    	acct = new Account();
    }
    public PageReference save() {
        try
    	{
    		insert acct;
    	}
    	catch(Exception e)
    	{
    		e.getStackTraceString();
    	}
    	return new PageReference('/'+acct.Id);
    }
}