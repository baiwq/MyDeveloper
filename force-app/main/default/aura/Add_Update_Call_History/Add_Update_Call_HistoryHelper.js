({
    InitHelp : function(cmp,event) {
    	//这里的c.代表调用服务器端方法
    	var action = cmp.get("c.GetCallHistoryListValue");
    	action.setParams({
    		"recordId": cmp.get("v.recordId")
    	})
        //调用回掉函数
        action.setCallback(this, function(response)
        {
            //定义提示信息
            var toastEvent = $A.get("e.force:showToast");
            var state = response.getState();
            //判断后台返回状态
            if(state == "SUCCESS")
            {
            	var returnValue = JSON.parse(response.getReturnValue());
            	var call = new Object();
            	returnValue[returnValue.length] = call;
		    	cmp.set("v.callList", returnValue);
            }
            else
            {
                //设置错误提示信息 
                cmp.find('notifLib').showNotice({
                    "variant": "error",
                    "header": "错误!",
                    "message": errorMessage,
                });
            }
            //将提示信息发出 如果不写这句话 将不会有提示信息 这个事件是系统自带事件，Lightning框架会监听这个事件
            toastEvent.fire();
            //将Loading图标取消
            var spinner = cmp.find("mySpinner");
            $A.util.toggleClass(spinner,"slds-hide");
        });
        //从客户端控制器调用服务器端控制器操作
        $A.enqueueAction(action);
    },
    DoSaveHelper : function(cmp,event)
    {
    	var callList = cmp.get("v.callList");
    	/*var stageNameList = new Array();
    	var saveSategList = new Array();
    	for (var i = stageList.length - 1; i >= 0; i--) {
    		var stage = stageList[i];
    		if(stage.stageName != null && stage.stageName != "" && stageNameList.indexOf(stage.stageName) == -1)
    		{
    			stageNameList[stageNameList.length] = stage.stageName;
    			saveSategList[saveSategList.length] = stage;
    		}
    		else if(stage.stageName != null && stage.stageName != "" && stageNameList.indexOf(stage.stageName) != -1)
    		{
    			//设置错误提示信息 
                cmp.find('notifLib').showNotice({
                    "variant": "error",
                    "header": "错误!",
                    "message": "不能多次添加相同的项目阶段！",
                });
                return;
    		}
    	}*/
    	var spinner = cmp.find("mySpinner");
        $A.util.toggleClass(spinner,"slds-hide");
    	//这里的c.代表调用服务器端方法
    	var action = cmp.get("c.DoSaveUpdateCallHistory");
    	action.setParams({
    		"recordId": cmp.get("v.recordId"),
    		"data": JSON.stringify(callList)
    	})
        //调用回掉函数
        action.setCallback(this, function(response)
        {
            //定义提示信息
            var toastEvent = $A.get("e.force:showToast");
            var state = response.getState();
            var returnvalue = response.getReturnValue();
            //判断后台返回状态
            if(state == "SUCCESS")
            {
            	if(returnvalue)
            	{
	            	toastEvent.setParams(
	                {
	                    "title" : "保存成功",
	                    "message" : "通话记录保存成功!",
	                    "type" : "SUCCESS"
	                });
	                $A.get("e.force:closeQuickAction").fire();
                    $A.get('e.force:refreshView').fire();
            	}
            	else
            	{
            		//设置错误提示信息 
	                cmp.find('notifLib').showNotice({
	                    "variant": "error",
	                    "header": "错误!",
	                    "message": "通话记录保存失败!",
	                });
            	}
            }
            else
            {
                //设置错误提示信息 
                cmp.find('notifLib').showNotice({
                    "variant": "error",
                    "header": "错误!",
                    "message": "通话记录保存失败!",
                });
            }
            //将提示信息发出 如果不写这句话 将不会有提示信息 这个事件是系统自带事件，Lightning框架会监听这个事件
            toastEvent.fire();
            //将Loading图标取消
            var spinner = cmp.find("mySpinner");
            $A.util.toggleClass(spinner,"slds-hide");
        });
        //从客户端控制器调用服务器端控制器操作
        $A.enqueueAction(action);
    }
})