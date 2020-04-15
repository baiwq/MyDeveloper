/**
 * @File Name          : AccountController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 2020/1/19 下午4:06:53
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    2020/1/19   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
  }
}