import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { FlowAttributeChangeEvent } from 'lightning/flowSupport';

export default class UpdateAccountFlow extends LightningElement {
    @api recordId;
    flowApiName = 'Update_Account_Flow';
    renderFlow = false;
    isFlowFailed = false;

    get inputVariables() {
        return [
            {
                name: 'accountId',
                type: 'String',
                value: this.recordId
            }
        ];
    }
    handleFlowStatusChange(event) {
        if (event.detail.status === 'FINISHED') {
            this.renderFlow = false;
            this.showToast('Success', 'Flow completed successfully', 'success');
            window.location.reload();
        } else if (event.detail.status === 'ERROR') {
            this.renderFlow = false;
            this.isFlowFailed = true;
            this.showToast('Error', 'Flow encountered an error', 'error');
        }
    }
    startFlow() {
        this.renderFlow = true;
    }
    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(toastEvent);
    }
}