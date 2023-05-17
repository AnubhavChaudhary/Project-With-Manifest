import { LightningElement,track } from 'lwc';

export default class FirstLWC extends LightningElement {
    @track greeting;
    textChanged(event){
        this.greeting=event.target.value;
    }
}