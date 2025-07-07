public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String stage) {
    
        // Query to fetch all opportunities
        return [SELECT Id, Name, StageName, Account.Name, Amount, CloseDate FROM Opportunity WHERE StageName = :stage LIMIT 10];
    }
}