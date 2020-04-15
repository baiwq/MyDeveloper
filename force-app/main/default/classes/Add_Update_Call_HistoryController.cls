/*************************************************************************************************************************
    * Class Name: Add_Update_Call_HistoryController
    * @作者: Mark
    * @时间: 2019-3-31
    * @功能: 实现添加和修改通话记录的功能       
    * @日志:
    *   ----------------------------------------------------------------------------------------------------------------------
    *   开发者                     日期                    备注
    *   ----------------------------------------------------------------------------------------------------------------------
    *   Mark                    2019-3-27                 
**************************************************************************************************************************/
public without sharing class Add_Update_Call_HistoryController {
	//
    @AuraEnabled
    public static String GetCallHistoryListValue(String recordId) 
    {
    	List<Call__c> valueList = [SELECT Account__c,Call_Time__c,Remark__c FROM Call__c WHERE Account__c =: recordId];
        return JSON.serializePretty(valueList);
    }

    @AuraEnabled
    public static Boolean DoSaveUpdateCallHistory(String recordId,String data) 
    {
    	Boolean success = false;
    	System.debug('====data:'+data);
    	try
    	{
    		List<Call__c> newchList = new List<Call__c>();
    		List<Call__c> chList = (List<Call__c>) JSON.deserializeStrict(data, List<Call__c>.class);
	        for(Call__c call : chList)
	        {	
	        	call.Account__c = recordId;
	        	newchList.add(call);
	        }
	        UPSERT newchList;
	        success = true;
    	}
    	catch(Exception e)
    	{
    		success = false;
    	}
    	return success;
    }

    /*public class PlickListValue
    {
        public String valueAPI{get;set;}
        public String valueLabel{get;set;}
    }

    public class StageData {
		public String stageName{get;set;}
		public Date stopTime{get;set;}
		public Date startTime{get;set;}
		public String description{get;set;}
	}*/
}