import { LightningElement, api, track } from 'lwc';

export default class ChildComponent extends LightningElement {
    @track message = '';
    @api parentInput = 'default Parent Message';
    @api parentButton = 'default Parent Button';

    handleInputChange(event) {
        this.message = event.target.value;
    }

    sendMessage() {
        const messageEvent = new CustomEvent('messagefromchild', {
            detail: { message: this.message }
        });
        this.dispatchEvent(messageEvent);
    }

    resetMessage(event) {
        this.message = '';
        const resetEvent = new CustomEvent('reset');
        this.dispatchEvent(resetEvent);
    }

    @api
    updateChildMessage(newMessage) {
        this.parentButton = newMessage;
    }
}