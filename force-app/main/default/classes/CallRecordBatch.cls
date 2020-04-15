global class CallRecordBatch implements Database.Batchable<sObject> {
    public String query;
    Map<Id,Integer> map_sum = new Map<Id,Integer>();
    global CallRecordBatch() 
    {
        this.query = 'select Account__c from Call__c where createdDate = yesterday';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, list<Sobject> scope) 
    {
        System.debug('=======execute方法执行');
        for (Call__c call: (List<Call__c>) scope) {
            //存在的情况
            if(map_sum.containsKey(call.Account__c))
            {
                map_sum.put(call.Account__c, map_sum.get(call.Account__c)+1);
            }
            else//不存在的情况
            {
                map_sum.put(call.Account__c, 1);
            }
        }
        System.debug('=======execute方法执行结束');
    }

    global void finish(Database.BatchableContext BC) 
    {
        List<Account> accList = [select Id,Number_Of_Calls_Yesterday__c from Account where Id in: map_sum.keySet()];
         for (Account acc: accList) 
        {
            if (map_sum.containsKey(acc.Id)) 
            {
                if (acc.Number_Of_Calls_Yesterday__c == null) 
                {
                    acc.Number_Of_Calls_Yesterday__c = map_sum.get(acc.Id);
                }
                else
                {
                    acc.Number_Of_Calls_Yesterday__c += map_sum.get(acc.Id);
                }
                
            }
        }
        System.debug('=======finish方法 执行结束');
        update accList;
    }
}