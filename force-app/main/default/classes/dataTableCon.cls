public class dataTableCon {
    
        List<Account> accounts;
        public List<Account> getAccounts()
        {
        	if(accounts==null)
        		accounts = [SELECT name,site,type,accountNumber FROM account LIMIT 1];
        	return accounts;
        }
    
}