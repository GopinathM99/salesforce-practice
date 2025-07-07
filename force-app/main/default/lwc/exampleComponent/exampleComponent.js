import { LightningElement } from 'lwc';
import fetchOpportunities from '@salesforce/apex/MyController.fetchOpportunities';

export default class exampleComponent extends LightningElement {
    opportunities;
    selectedStage = 'Closed Won';
    stageOptions = [
        { label: 'Closed Won', value: 'Closed Won' },
        { label: 'Closed Lost', value: 'Closed Lost' },
        { label: 'Prospecting', value: 'Prospecting' },
        { label: 'Qualification', value: 'Qualification' },
        { label: 'Needs Analysis', value: 'Needs Analysis' },
        { label: 'Value Proposition', value: 'Value Proposition' }];
    error;

    columns = [
        { label: 'Opportunity Name', fieldName: 'Name', type: 'text' },
        { label: 'Stage', fieldName: 'StageName', type: 'text' },
        { label: 'Amount', fieldName: 'Amount', type: 'currency' },
        { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
    ];

    connectedCallback() {
        this.loadOpportunities();
    }

    loadOpportunities() {
        fetchOpportunities({StageName: this.selectedStage})
            .then(result => {
                this.opportunities = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.opportunities = undefined;
            });
        }

    handleStageChange(event) {
        this.selectedStage = event.target.value;
        // this.loadOpportunities();
    }

    handleChange(event) {
        //this.selectedStage = event.detail.value;
        this.loadOpportunities();
    }

}