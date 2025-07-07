import { LightningElement, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunityController.getOpportunities';

export default class OpportunityList extends LightningElement {
    selectedStage = 'Closed Won';
    opportunities;
    error;
    stageOptions = [
        { label: 'Closed Won', value: 'Closed Won' },
        { label: 'Closed Lost', value: 'Closed Lost' },
        { label: 'In Progress', value: 'In Progress' },
        { label: 'New', value: 'New' },
        { label: 'Open', value: 'Open' },
        { label: 'All', value: 'All' }
    ];
    columns = [
        { label: 'Opportunity Name', fieldName: 'Name', type: 'text' },
        { label: 'Stage', fieldName: 'StageName', type: 'text' },
        { label: 'Amount', fieldName: 'Amount', type: 'currency' },
        { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
        //{ label: 'Account Name', fieldName: 'Account.Name', type: 'text' }
    ];

    @wire(getOpportunities, { stage: '$selectedStage' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunities = data;
            console.log('Opportunities fetched successfully:', data);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
            console.error('Error fetching opportunities:', error);
        }
    }

    handleStageChange(event) {
        this.selectedStage = event.detail.value;
    }
}