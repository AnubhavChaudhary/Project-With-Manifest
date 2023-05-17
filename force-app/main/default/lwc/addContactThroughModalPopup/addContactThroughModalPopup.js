import { LightningElement,api,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import Contact_Salutation from '@salesforce/schema/Contact.Salutation';
import Contact_FirstName from '@salesforce/schema/Contact.FirstName';
import Contact_LastName from '@salesforce/schema/Contact.LastName';
import Contact_Email from '@salesforce/schema/Contact.Email';
import Contact_Phone from '@salesforce/schema/Contact.Phone';

export default class AddContactThroughModalPopup extends LightningElement {
    @api isModalOpen;
    @api recordId;
    @api isNew;
    Fields = [Contact_Salutation,Contact_FirstName,Contact_LastName,Contact_Email,Contact_Phone];
    objectApiName='Contact';
    createdUpdated = '';

    
    
    recordCreated(event){
        if(this.isNew === true)
        {
            this.createdUpdated = 'Contact Created Successfully';
        }
        else
        {
            this.createdUpdated = 'Contact Updated Successfully';
        }
        const toastEvent= new ShowToastEvent({
            title: this.createdUpdated,
            message: 'Record Id' + event.detail.id,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(toastEvent);
        const newRecordCreated= new CustomEvent("newrecordcreated",{
            detail: 'result'
        });
        this.dispatchEvent(newRecordCreated);
        this.isModalOpen = false;
        this.closePopup();
        this.clearId();
    }
    recordUpdated(event){

    }
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
        this.closePopup();
        this.clearId();
    }
    closePopup()
    {        
        const closePopup = new CustomEvent("popupclosed",{
            detail:this.isModalOpen
        });
        this.dispatchEvent(closePopup);
    }
    clearId()
    {
        const editForm = this.template.querySelector('lightning-record-form');
        editForm.recordId = null;
        this.recordId = null;
        const clearId = new CustomEvent("recordcleared",{
            detail:this.recordId
        });
        this.dispatchEvent(clearId);
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }
}