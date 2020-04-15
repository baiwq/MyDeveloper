public  class Input {

    public String inputValue{get;set;}

    public void getString(){
    	System.debug(inputValue);
    	try
    	{
    		Account acct = new Account();
    		acct.Name = inputValue;
    		insert acct;
    	}
    	catch(Exception e)
    	{
    		e.getStackTraceString();
    	}

    }
}