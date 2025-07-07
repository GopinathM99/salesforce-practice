import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SAMPLE_CHANNEL from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class PublisherComponent extends LightningElement {

    message = 'Hello from Publisher Component';
    @wire(MessageContext)
    messageContext;

    handleInputChange(event) {
        this.message = event.target.value;
    }

    publishMessage() {
        const payload = {
            messageText: this.message
        };
        publish(this.messageContext, SAMPLE_CHANNEL, payload);
    }

}