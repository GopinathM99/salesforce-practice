public class UpdateOpportunityDescriptionBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, CloseDate FROM Opportunity');
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for (Opportunity opp : scope) {
            if (opp.CloseDate != null) {
                opp.Description = 'Hey!! Please close this one by ' + opp.CloseDate.format();
                opportunitiesToUpdate.add(opp);
            }
        }
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Send a notification email or perform other post-processing
    }
}
