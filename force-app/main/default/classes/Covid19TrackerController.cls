public without sharing class Covid19TrackerController {

   @AuraEnabled(continuation=true cacheable = true)
    public static  Map<String, Object> getCov19Data(){
        Map<String, Object> results  = new Map<String, Object> ();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.covid19api.com/summary');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }

        return results;
    }

}