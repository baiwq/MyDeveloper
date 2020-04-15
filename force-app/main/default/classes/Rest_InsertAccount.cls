/**********************************************************************
 * @author:Mark
 * @createdate:2019-3-28
 * @url: /services/apexrest/insertAccount
 * @description:定义Rest_InsertAccount类，调用该接口，可以插入客户数据
 * @data:
 *  {
        "Name":"Mark"
    }
*************************************************************************/
@RestResource(urlMapping='/insertAccount')
global without sharing class Rest_InsertAccount
{
    @HttpPost
    global static String doPost()
    {
    	// 获取RestRequest对象，取到相应的内容
    	RestRequest req = RestContext.request;
    	RestResponse res = RestContext.response;
    	res.addHeader('Content-Type', 'Application/json');
    	// 获取请求的内容
    	String reqbody = req.requestBody.toString();
    	List<Account> accountList = (List<Account>)JSON.deserialize(reqbody, List<Account>.class);
    	insert accountList;
        return null;
    }
}