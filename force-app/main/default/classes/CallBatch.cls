global class CallBatch implements Database.Batchable<sObject> {
    public String query;
    
    global CallBatch() 
    {
        this.query = 'select Id,Account__c,TextTest__c from Call__c where createdDate = today';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, list<Sobject> scope) 
    {
        System.debug('=======execute方法执行');
        Map<Id,Integer> map_sum = new Map<Id,Integer>();      
        for (Call__c call: (List<Call__c>) scope) {
            //存在的情况
            if(map_sum.containsKey(call.Account__c))
            {
                map_sum.put(call.Account__c, map_sum.get(call.Account__c)+1);
            }
            else//不存在的情况
            {
                map_sum.put(call.Account__c, 1);
                System.debug(call.TextTest__c);
            }
        }
        System.debug('=======查询执行结束');
        Set<Id> set_Id = map_sum.keySet();
        List<Account> accountList = new List<Account>();
        for (Id strId :set_Id ) {
            Account acc = new Account();
            acc.Id = strId;
            acc.Number_Of_Calls_Yesterday__c = map_sum.get(strId);
            accountList.add(acc);
        }
        update accountList;
    }

    global void finish(Database.BatchableContext BC) 
    {
        
    }
}