public with sharing class MyController {
    @AuraEnabled
    public static List<Opportunity> fetchOpportunities(String StageName){
        return [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE StageName = :StageName LIMIT 10];
    }
}