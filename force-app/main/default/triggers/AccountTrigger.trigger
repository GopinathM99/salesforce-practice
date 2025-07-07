trigger AccountTrigger on Account (before insert, after insert, before update, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {
        // Call the handler class to process the logic
        AccountTriggerHandler.handleBeforeInsert(Trigger.new);
    } else if (Trigger.isAfter && Trigger.isInsert) {
        // Call the handler class to process the logic
        AccountTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    } else if (Trigger.isBefore && Trigger.isUpdate) {
        // Call the handler class to process the logic
        AccountTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isAfter && Trigger.isUpdate) {
        // Call the handler class to process the logic
        AccountTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
         
    }

}