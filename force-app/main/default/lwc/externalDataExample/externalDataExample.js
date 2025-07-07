import { LightningElement } from 'lwc';

export default class ExternalDataExample extends LightningElement {
    data;
    catFact;
    error;

    async fetchExternalData() {
        try {
            const response = await fetch('https://catfact.ninja/fact', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
            }
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            this.data = await response.json();
            this.catFact = this.data.fact;
            //this.data = await response;
            console.log(this.data);
        } catch (error) {
            this.error = error.message;
            this.data = undefined;
        }
    }
}