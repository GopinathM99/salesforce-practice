@isTest
private class OpportunitySummaryBatchTest {
    @TestSetup
    static void setup(){
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 0; i < 100; i++) {
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                Amount = 1000 + (i * 100),
                CloseDate = System.today().addDays(-i),
                StageName = 'Closed Won'
                ));
        }
        insert opportunities;
    }

    @isTest
    static void testBatchProcessing() {
        Test.startTest();
        OpportunitySummaryBatch batch = new OpportunitySummaryBatch();
        Database.executeBatch(batch, 100);
        Test.stopTest();

        // Verify the results
        // System.assertEquals(10, batch.totalRecordsProcessed, 'Total records processed should be 10');
        // System.assertEquals(55000, batch.totalAmount, 'Total amount processed should be 55000');
        // System.assertEquals(0, batch.errorMessages.size(), 'There should be no error messages');
        

        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE JobType = 'BatchApex' LIMIT 1];
        System.assertEquals('Completed', job.Status, 'Batch job should be completed');
    }
}