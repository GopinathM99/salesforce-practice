import { LightningElement, track, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class ChainedWireExample extends LightningElement {
    @track recordTypeId;
    error;
    @track picklistValues;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
            console.log('Record Type ID:', this.recordTypeId);
        } else if (error) {
            this.error = error;
            console.error('Error fetching object info:', error);
        }
    }

    @wire(getPicklistValues, {
        recordTypeId: '$recordTypeId',
        fieldApiName: TYPE_FIELD
    })
    picklistValues;

    get hasPicklistValues() {
        console.log('Picklist Values:', this.picklistValues);
        return this.picklistValues?.data?.values; 
    }

}