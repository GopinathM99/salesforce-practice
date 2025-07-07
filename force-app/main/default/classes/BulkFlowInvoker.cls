public with sharing class BulkFlowInvoker {
    public static String invokeFlow(List<Id> accountIds, String newNameValue) {
        
        if (accountIds == null || accountIds.isEmpty()) {
            return 'No account IDs provided';
        }

        Map<String, Object> inputVariables = new Map<String, Object>();
        inputVariables.put('accountIds', accountIds);
        inputVariables.put('newNameValue', newNameValue);
        
        // Create a new Flow.Interview instance
        Flow.Interview flowInterview = Flow.Interview.createInterview('BulkUpdateAccountStatus', inputVariables);
        
        try {
                    // Start the flow
            flowInterview.start();
            
            String result = (String) flowInterview.getVariableValue('successMessage');
            return result != null ? result : 'Flow did not return a result';
            
        } catch (Exception e) {
            // Handle any exceptions that occur during flow execution
            return 'An error occurred while executing the flow: ' + e.getMessage();
            
        }
    }
}