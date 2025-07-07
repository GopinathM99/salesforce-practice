trigger OpportunityTrigger on Opportunity (before update, after update, before insert, after insert) {
    // Prevent recursive trigger execution
    if (!OpportunityTriggerHandler.hasRun) {
            
        //OpportunityTriggerHandler.hasRun = true;
    
        if (Trigger.isBefore && Trigger.isInsert) {
            // Call the handler class to process the logic
            OpportunityTriggerHandler.handleBeforeInsert(Trigger.new);
        } else if (Trigger.isAfter && Trigger.isInsert) {
            // Call the handler class to process the logic
            OpportunityTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
        } else if (Trigger.isBefore && Trigger.isUpdate) {
            // Call the handler class to process the logic
            OpportunityTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        } else if (Trigger.isAfter && Trigger.isUpdate) {
            // Call the handler class to process the logic
            OpportunityTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
    }
}