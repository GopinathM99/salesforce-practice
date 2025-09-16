@isTest
public class UpdateOpportunityDescriptionBatchTest {

    @isTest
    static void testBatch() {
        // Create test data
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(i)
            ));
        }
        insert opportunities;

        // Execute the batch job
        Test.startTest();
        UpdateOpportunityDescriptionBatch batch = new UpdateOpportunityDescriptionBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify the results
        List<Opportunity> updatedOpps = [SELECT Id, Description, CloseDate FROM Opportunity WHERE Name LIKE 'Test Opportunity %'];
        for (Opportunity opp : updatedOpps) {
            String expectedDescription = 'Hey!! Please close this one by ' + opp.CloseDate.format();
            System.assertEquals(expectedDescription, opp.Description, 'The description should be updated.');
        }
    }
}
