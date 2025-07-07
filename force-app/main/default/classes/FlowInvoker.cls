public with sharing class FlowInvoker {
    public static String invokeFlow(Id accountId) {
        
        Map<String, Object> inputVariables = new Map<String, Object>();
        inputVariables.put('accountId', accountId);
        // Create a new Flow.Interview instance
        Flow.Interview flowInterview = Flow.Interview.createInterview('Update_Account_Status', inputVariables);
        
        // Start the flow
        flowInterview.start();
        
        String result = (String) flowInterview.getVariableValue('successMessage');
        return result != null ? result : 'Flow did not return a result';
    }
    public static void invokeListFlow(List<Id> accountIds) {
        
        for (Id accountId : accountIds) {
            Map<String, Object> inputVariables = new Map<String, Object>();
            inputVariables.put('accountId', accountId);
            // Create a new Flow.Interview instance
            Flow.Interview flowInterview = Flow.Interview.createInterview('Update_Account_Status', inputVariables);
            
            // Start the flow
            flowInterview.start();
            
            String result = (String) flowInterview.getVariableValue('successMessage');
            System.debug(result != null ? result : 'Flow did not return a result');  
        }
    }
}