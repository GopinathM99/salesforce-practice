public with sharing class MyBatchCallout implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query to select records to process
        return Database.getQueryLocator('SELECT Id, Name FROM Account Limit 10');
    }
    public void execute(Database.BatchableContext BC, List<Account> scope) {
        // Process each record in the scope
        for (Account record : scope) {
            // Perform callout or other processing logic here
            // Example: HttpRequest, HttpResponse, etc.
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://catfact.ninja/fact');
            req.setHeader('content-type', 'application/json');
            req.setHeader('accept', 'application/json');
            req.setMethod('GET');
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('Response: ' + res.getBody());
        }
    }
    public void finish(Database.BatchableContext BC) {
        // Final processing after all records have been processed
        // Example: Send notification, log results, etc.
    }
}