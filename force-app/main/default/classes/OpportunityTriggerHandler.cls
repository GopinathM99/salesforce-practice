public class OpportunityTriggerHandler {

    public static Boolean hasRun = false;

    public static void handleBeforeInsert(List<Opportunity> newOpportunities) {
        
    }

    public static void handleAfterInsert(List<Opportunity> newOpportunities, Map<Id, Opportunity> newMap) {
        Set<Id> accountIds = new Set<Id>();
        System.debug('Handling after insert for Opportunities: ' + newOpportunities);
        for (Opportunity opp : newOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        if (!accountIds.isEmpty()) {
            FlowInvoker.invokeListFlow(new List<Id>(accountIds)); // Assuming FlowInvoker is a utility class to invoke flows
        }
    }

    public static void handleBeforeUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldMap) {
        for(Opportunity opp : newOpportunities) {
            opp.Priority__c = opp.Amount > 100000 ?  'High': 'Low'; // Example logic: Set a default value for a custom field
        }
    }

    public static void handleAfterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldMap, Map<Id, Opportunity> newMap) {
        
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpportunities) {
            if (opp.Amount != null && opp.Amount != oldMap.get(opp.Id).Amount) {
                accountIds.add(opp.AccountId);
            }
        }
        if (!accountIds.isEmpty()) {
            List<Account> accountsToUpdate = [SELECT Id, Last_Opportunity_Update__c FROM Account WHERE Id IN :accountIds];
            for (Account acc : accountsToUpdate) {
                acc.Last_Opportunity_Update__c = System.now(); // Example logic: Update a custom field on Account
            }
            update accountsToUpdate;
        }
    }
}