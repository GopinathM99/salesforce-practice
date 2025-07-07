public class AccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            // Example logic: Set a default value for a custom field
            if (acc.AccountNumber == null) {
                acc.AccountNumber = String.valueOf(1000000 + Integer.valueOf(Math.floor(Math.random() * 9000000)));
            }
        }
    }

    public static void handleAfterInsert(List<Account> newAccounts, Map<Id, Account> newMap) {
        // Handle the after insert logic
    }
    public static void handleBeforeUpdate(List<Account> newAccounts, Map<Id, Account> oldMap) {
        for (Account acc : newAccounts) {
            // Example logic: Set a default value for a custom field
            if (acc.AccountNumber == null) {
                acc.AccountNumber = String.valueOf(1000000 + Integer.valueOf(Math.floor(Math.random() * 9000000)));
            }
        }
    }

    public static void handleAfterUpdate(List<Account> newAccounts, Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : newAccounts) {
            if (acc.Phone != null && acc.Phone != oldMap.get(acc.Id).Phone) {
                accountIds.add(acc.Id);
            }
        }
        if (!accountIds.isEmpty()) {
           List<Opportunity> opportunitiesToUpdate = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountIds];
           for (Opportunity opp : opportunitiesToUpdate) {
               opp.NextStep = 'Account Phone Number updated to : ' + String.valueOf(newMap.get(opp.AccountId).Phone); // Example logic: Clear the AccountId on related Opportunities 
           }
           update opportunitiesToUpdate;
        }
    }
}