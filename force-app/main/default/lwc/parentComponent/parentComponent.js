import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    recievedMessage = 'No Message Received Yet';
    @track parentMessage = 'Parent to Child Default Message';
    parentButton = 'From Parent Button';
    @track parent2Message = 'Default Message for Other Child';

    handleMessage(event) {
        this.recievedMessage = event.detail.message;
        this.parent2Message = event.detail.message;
    }

    handleReset(event) {
        this.recievedMessage = '';
    }

    updateChildMessage() {
        const childComponent = this.template.querySelector('c-child-component');
        if (childComponent) {
            childComponent.updateChildMessage(this.parentButton);
        }
    }

    handleInputChange(event) {
        if (event.target.name === 'parentMessage') {
            this.parentMessage = event.target.value;
        }
        if (event.target.name === 'parent2Message') {
            this.parent2Message = event.target.value;
        }
    }

}