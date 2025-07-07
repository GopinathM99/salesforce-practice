import { LightningElement, api } from 'lwc';

export default class Child2 extends LightningElement {
    @api otherChildMessage = 'Parent to Child Default Message';
}