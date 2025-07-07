public with sharing class QueueableJobExample implements Queueable, Database.AllowsCallouts {
    private Integer jobNumber;
    private List<Id> accountIds;

    public QueueableJobExample( Integer jobNumber, List<Id> accountIds) {
        this.jobNumber = jobNumber;
        this.accountIds = accountIds;
        // You can initialize other variables or perform setup here
        System.debug('QueueableJobExample initialized with jobNumber: ' + jobNumber + ' and accountIds: ' + accountIds);

    }

    public void execute(QueueableContext context) {
        // Perform callout or other processing logic here
        System.debug('Running QueueableJobExample with jobNumber: ' + jobNumber + ' with Limit: ' + Limits.getCallouts() + '/' + Limits.getLimitCallouts());
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://catfact.ninja/fact');
        req.setHeader('content-type', 'application/json');
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        System.debug('Response: ' + res.getBody());

        List<Account> accountsToUpdate = [SELECT Id, Name FROM Account WHERE Id IN :accountIds LIMIT 30];
        Set<Id> currentlyProcessedIds = new Set<Id>();

        for (Account acc : accountsToUpdate) {
            acc.description = 'Updated by Queueable Job 05/29 - ' + jobNumber;
            System.debug('Updating Account: ' + acc.Name);
            currentlyProcessedIds.add(acc.Id);
        }

        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
            System.debug('Accounts to update: ' + accountsToUpdate.size() + ' for jobNumber: ' + jobNumber);
        } else {
            System.debug('No accounts found to update for jobNumber: ' + jobNumber);
        }

        List<Id> remainingAccountIds = new List<Id>();
        for (Id accId : accountIds) {
            if (!currentlyProcessedIds.contains(accId)) {
                remainingAccountIds.add(accId);
            }
        }


        if(jobNumber < 3 && !Test.isRunningTest()) {
            // Chain another Queueable job if the job number is less than 5
            System.debug('Chaining another QueueableJobExample with jobNumber: ' + (jobNumber + 1));
            System.enqueueJob(new QueueableJobExample(jobNumber + 1, remainingAccountIds));
        } else {
            System.debug('No more jobs to chain. Job number reached: ' + jobNumber);
        }
    }

    public static void startJob(List<Id> accountIds) {
        // Start the first Queueable job with jobNumber 1
        System.debug('Starting QueueableJobExample with jobNumber: 1');
        System.enqueueJob(new QueueableJobExample(1, accountIds));
    }

}