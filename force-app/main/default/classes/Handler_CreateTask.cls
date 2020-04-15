/*************************************************************************************************************************
    * Class Name : Handler_CreateTask
    * @作者: Mark
    * @时间: 2019-3-27
    * @功能: 新建业务机会的时候，给业务机会对应客户的首要联系人创建一个跟进的任务
    *        
    * @日志:
    *   ----------------------------------------------------------------------------------------------------------------------
    *   开发者                     日期                    备注
    *   ----------------------------------------------------------------------------------------------------------------------
    *   Mark                    2019-3-27                 创建
**************************************************************************************************************************/
public class Handler_CreateTask implements Triggers.Handler//whitout sharing
{
	public void handle()
	{
		TriggerSwitch__c ts = TriggerSwitch__c.getValues('Handler_CreateTask');
        if(ts == null || ts.IsActive__c == true)
        {
            // createTask();
        }
	}
    public void createTask()
    {
    	//soQL不要写在for循环中，解决双层for循环的问题
    	System.debug('=====================进入Handler_CreateTask功能！！！！！');
    	// List<Opportunity> opty_list= ;
    	List<Task> task_list = new List<TasK>();
    	Set<String> accountIds = new Set<String>();
    	for (Opportunity opty : (List<Opportunity>)Trigger.new) 
    	{
    		accountIds.add(opty.AccountId);
    	}
	    //查找该客户的主要联系人
	    List<Contact> contact_list = [select Id from Contact where Level__c='Primary' and AccountId in: accountIds];
	    	System.debug('=============contact_list:'+contact_list);
	    	for (Contact con: contact_list) 
	    	{
	    		Task task = new Task();
	    		task.Subject = 'Call';
	    		task.WhoId = con.Id;
	    		//关联业务机会
	    		// task.WhatId = opty.Id;
	    		task_list.add(task);
	    		System.debug('==========task:'+task);
	    	}	
    	insert task_list;
    }
}