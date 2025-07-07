public with sharing class OpportunitySummaryBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Decimal totalAmount = 0.0;
    public Integer totalRecordsProcessed = 0;
    public List<String> errorMessages = new List<String>();

    // Constructor
        
    public OpportunitySummaryBatch() {

    }
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query to select all opportunities
        return Database.getQueryLocator('SELECT Id, Name, Amount, CloseDate FROM Opportunity where IsClosed = true AND closeDate = last_N_Days:365');
    }
    public void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        //List<Opportunity> opportunities = (List<Opportunity>)scope;

        try {
            for (Opportunity opp : scope) {
                // Process each opportunity
                totalAmount += opp.Amount;
                totalRecordsProcessed++;
            }
        } catch (Exception e) {
            // Handle any exceptions that occur during processing
            errorMessages.add('Error processing opportunities: ' + e.getMessage());
        } 
        }

    public void finish(Database.BatchableContext BC) {
        // Final actions after batch processing, if needed
        System.debug('Batch processing completed.');
        String subject = 'Opportunity Summary Batch Completed';
        String body = 'Total Amount Processed: ' + totalAmount + '\n' +
                      'Total Records Processed: ' + totalRecordsProcessed + '\n' +
                      'Errors: ' + String.join(errorMessages, ', ');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { UserInfo.getUserEmail() });
        System.debug('Sending email to: ' + UserInfo.getUserEmail());
        System.debug('Total amount: ' + totalAmount);
        System.debug('Total records processed: ' + totalRecordsProcessed);
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