import { LightningElement, track } from 'lwc';

export default class MyFirstLightningWevComponent extends LightningElement {
    @track
    Contacts = [
        {
            Id:1,
            Name:'Anubhav',
            Phone:90111
        },
        {
            Id:2,
            Name:'Mohit',
            Phone:87878
        },
        {
            Id:3,
            Name:'Gaurav',
            Phone:52445
        }
    ]
}