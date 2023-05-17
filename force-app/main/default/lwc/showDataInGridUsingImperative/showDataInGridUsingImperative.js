import { LightningElement,track } from 'lwc';
import getContactData from '@salesforce/apex/showDatainGrid.GetAccounts';
import filterContacts from '@salesforce/apex/showDatainGrid.filterContacts';
import Contact_Salutation from '@salesforce/schema/Contact.Salutation';
import Contact_FirstName from '@salesforce/schema/Contact.FirstName';
import Contact_LastName from '@salesforce/schema/Contact.LastName';
import Contact_Email from '@salesforce/schema/Contact.Email';
import Contact_Phone from '@salesforce/schema/Contact.Phone';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class ShowDataInGridUsingImperative extends LightningElement {
    @track contactData;
    isChildModalOpen = false;
    isDeleteRow = false;
    editRecordId;
    deleteRowId;
    message;
    heading;
    @track isNewRecord = true;
    @track searchMe;
    @track isLoading = false;
    Fields = [Contact_Salutation,Contact_FirstName,Contact_LastName,Contact_Email,Contact_Phone];
    objectApiName='Contact';

    handleNewRecordCreated(event){
        console.log(event.detail);
        this.callGetContactData();
    }

    handlePopUpClosed(event){
        this.isChildModalOpen = event.detail;
    }
    openChildModal() {
        this.isChildModalOpen = true;
        this.isNewRecord = true;
    }
    actions = [
        {
            label:'Edit',name:'edit'
        },
        {
            label:'Delete',name:'delete'
        }
    ];
    @track columns=[
        {
            label:'Name', fieldName:'Name', type: 'text'
        },
        {
            label:'Phone', fieldName:'Phone', type: 'phone'
        },
        {
            label:'Mail', fieldName:'Email', type: 'email'
        },
        {
            type:'action',
            typeAttributes:{rowActions:this.actions}
        }
    ]
    handleRowAction(event){
        const eventName = event.detail.action.name;
        const row = event.detail.row;
        switch(eventName){
            case 'delete':
                this.deleteRow(row);
                break;
            case 'edit':
                this.editRow(row);
                break;
            
        }
    }

    handleRecordCleared(event){
        console.log(event.detail);
        this.editRecordId = event.detail;
    }

    deleteRow(row){
        console.log(row);
        this.heading = 'Delete Contact';
        this.message = 'Are you sure you want to delete?';
        this.isDeleteRow = true;
        this.deleteRowId = row.Id;
    }

    handleGotConfirmation(event){
        console.log(this.deleteRowId);
        this.isLoading=true;
        deleteRecord(this.deleteRowId)
        .then(()=>{
            for(let con in this.contactData){
                if(this.contactData[con].Id == this.deleteRowId){
                    this.contactData.splice(con, 1);
                    break;
                }
            }
            this.isLoading=false;
            this.isDeleteRow=event.detail;
        })
    }

    editRow(row){
        
        this.isChildModalOpen = true;
        this.isNewRecord = false;
        this.editRecordId = row.Id;
    }
    connectedCallback(){
        this.callGetContactData();
    }

    callGetContactData()
    {
        this.isLoading=true;
        getContactData()
        .then(result=>{
            console.log(result);
            this.isLoading=false;
            this.contactData=result;
        })
        .catch(error=>{
            this.isLoading=false;
            this.contactData=undefined;
        })
    }
    setNameVal(event){
        this.searchMe=event.target.value;
    }
    filterData(){
        filterContacts({Name: this.searchMe})
        .then(result=>{
            this.contactData=result;
        })
        .catch(error=>{
            this.contactData=undefined;
        })
    }
}