import { LightningElement } from 'lwc';
import Contact_Salutation from '@salesforce/schema/Contact.Salutation';
import Contact_FirstName from '@salesforce/schema/Contact.FirstName';
import Contact_LastName from '@salesforce/schema/Contact.LastName';
import Contact_Email from '@salesforce/schema/Contact.Email';
import Contact_Phone from '@salesforce/schema/Contact.Phone';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class AddNewContactUsingLRF extends LightningElement {
    Fields = [Contact_Salutation,Contact_FirstName,Contact_LastName,Contact_Email,Contact_Phone];
    objectApiName='Contact';

    recordCreated(event){
        const toastEvent= new ShowToastEvent({
            title: 'Contact Created',
            message: 'Record Id' + event.detail.id,
            variant: 'succcess'
        });
        this.dispatchEvent(toastEvent);
    }
}