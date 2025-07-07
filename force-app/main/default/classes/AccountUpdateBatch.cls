public with sharing class AccountUpdateBatch implements Database.Batchable<SObject>, Database.Stateful {
    Integer failedBatches = 0;
    List<String> errorMessages = new List<String>();

    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query to select all accounts
        return Database.getQueryLocator('SELECT Id, Name, Industry FROM Account where Industry = \'Energy\'');
    }
    public void execute(Database.BatchableContext BC, List<Account> scope) {
        try {
            for (Account acc : scope) {
                // Update account industry to 'Technology' if it is currently 'Finance'
                if (acc.Industry == 'Energy') {
                    acc.Industry = 'Technology';
                }
            }
            //update scope; // Update the accounts in the database
            List<Database.saveResult> results = Database.update(scope, false); // Use 'false' to allow partial success

            for (Database.SaveResult result : results) {
                if (!result.isSuccess()) {
                    failedBatches++;
                    errorMessages.add('Error updating account ID ' + result.getId() + ': ' + result.getErrors()[0].getMessage());
                }
            }

        } catch (Exception e) {
            // Handle any exceptions that occur during processing
            failedBatches++;
            errorMessages.add('Error processing accounts: ' + e.getMessage());
        }
    }
    public void finish(Database.BatchableContext BC) {
        // Final actions after batch processing, if needed
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Id = :BC.getJobId() LIMIT 1];
        if (failedBatches > 0) {
            // Send an email notifying the requesting user(s) of the error)
            System.debug('Batch processing completed.');
            String subject = 'Account Update Batch Completed';
            String body = 'Failed Batches: ' + failedBatches + '\n' +
                        'Errors: ' + String.join(errorMessages, ', ');
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { UserInfo.getUserEmail() });
            System.debug('Sending email to: ' + UserInfo.getUserEmail());
            System.debug('Failed batches: ' + failedBatches);
            System.debug('Errors: ' + String.join(errorMessages, ', '));
            email.setSubject(subject);
            email.setPlainTextBody(body);
            try {
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            } catch (Exception e) {
                System.debug('Error sending email: ' + e.getMessage());
            }
    }
    }
}