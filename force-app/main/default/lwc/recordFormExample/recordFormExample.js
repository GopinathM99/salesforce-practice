import { api, LightningElement } from 'lwc';

export default class RecordFormExample extends LightningElement {
    @api recordId; // Record ID passed from the parent component
    fields = ['Name', 'Industry', 'Phone', 'Website', 'Description']; // Fields to display in the form

    handleSuccess(event) {
        // Handle the success event after the record is saved
        const updatedRecord = event.detail.id;
        console.log('Record updated successfully:', updatedRecord);
        // Optionally, you can dispatch a custom event or perform additional actions here
    }

    handleError(event){
        // Handle the error event if the record save fails
        const error = event.detail;
        console.error('Error saving record:', error);
        // Optionally, you can display an error message or perform additional actions here
    }
}