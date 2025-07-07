public with sharing class OpenBusinessAccount {
    @InvocableMethod(label='Open Business Account' description='Opens a business account for a given contact') 
    public static List<Account> openAccount(List<FlowInputs> inputs) {
        List<Account> accounts = new List<Account>();
        for (FlowInputs input : inputs) {
            Account newAccount = new Account();
            newAccount.Name = 'Business Account for ' + input.accountId;
            newAccount.Type = 'Business';
            newAccount.OwnerId = UserInfo.getUserId(); // Set the owner to the current user
            accounts.add(newAccount);
        }
        if (!accounts.isEmpty()) {
            try {
                insert accounts;
            } catch (DmlException e) {
                // Handle the exception, e.g., log it or throw a custom exception
                // For an InvocableMethod, it's often best to let the Flow handle faults
                // For now, re-throwing to ensure the Flow is aware of the failure.
                throw e;
            }
        }
        return accounts;
    }

    public class FlowInputs {
        @InvocableVariable
        public String accountId;
    }
}