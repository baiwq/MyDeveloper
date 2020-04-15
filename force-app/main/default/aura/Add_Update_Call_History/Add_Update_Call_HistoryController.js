({
    doInit : function(component, event, helper) {
    	helper.InitHelp(component, event);
        var device = $A.get("$Browser.formFactor");
        if("DESKTOP" != device)
        {
            alert("移动端设备暂不支持此功能！");
            var a = component.get('c.CancelFunction');
            $A.enqueueAction(a);
        }
    },
    CancelFunction : function(component, event, helper)
    {
    	$A.get("e.force:closeQuickAction").fire();
    },
    AddLineFunction : function(component, event, helper)
    {
    	var callList = component.get("v.callList");
    	var call = new Object();
    	callList[callList.length] = call;
    	component.set("v.callList", callList);
    },
    DeleteFunction : function(component, event, helper)
    {
    	var callList = component.get("v.callList");
    	var sNo = event.getSource().get("v.value");
    	callList.splice(sNo,1);
    	component.set("v.callList", callList);
    },
    SaveFunction : function(component, event, helper)
    {
    	helper.DoSaveHelper(component, event);
    }
})