import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';   
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateRecordDemo extends LightningElement {

    accName = '';
    accPhone = '';

    handleChange(event) {
        const field = event.target.name;
        if (field === 'Name') {
            this.accName = event.target.value;
        } else if (field === 'Phone') {
            this.accPhone = event.target.value;
        }
    }

    createAccount() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.accName;
        fields[PHONE_FIELD.fieldApiName] = this.accPhone;   
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(record => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created with Id: ' + record.id,
                        variant: 'success'
                    })
                );
                this.accName = '';
                this.accPhone = '';
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            })
    }
    }