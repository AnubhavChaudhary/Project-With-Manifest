import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import UploadMultipleFiles from '@salesforce/apex/UploadMultipleFiles.uploadFiles';
import CreateCases from '@salesforce/apex/CreateCases.CreateCases';

export default class AddRecordThroughModelPopupWithUploadedFiles extends LightningElement {
    
    isrendered=false;
    @api isModalOpen;
    @api recordId;
    @api isNew;
    @api priorityOptions;
    @track priorityValue;
    @track descriptionValue;
    @track subjectValue;
    @track ccValue;
    @track showSpinner = false;
    @track recordId;
    @track filesData = [];


    renderedCallback(){
        if(!this.isrendered){
            this.isrendered = true;
            const styleTag = document.createElement('style');
            styleTag.innerText = "textarea { min-height: 100px; }";
            if(this.template.querySelector('lightning-textarea'))
            {
                this.template.querySelector('lightning-textarea').forEach((element) => {
                    element.appendChild(styleTag);
                })
            }
            //this.template.querySelector('lightning-textarea').appendChild(styleTag);
        }
        
    }
    
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
        this.closePopup();
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
        this.priorityValue = '';
        this.subjectValue = '';
        this.descriptionValue = '';
        this.ccValue = '';
    }

    handlePriorityChange(event)
    {
        this.priorityValue = event.target.value;
    }

    handleSubjectChanged(event)
    {
        this.subjectValue = event.target.value;
    }

    handleDescriptionChanged(event)
    {
        this.descriptionValue = event.target.value;
    }

    handleCcChanged(event)
    {
        this.ccValue = event.target.value;
    }

    isInputValid() {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
            //this.contact[inputField.name] = inputField.value;
        });
        return isValid;
    }

    submitDetails(event)
    {
        if(this.isInputValid()) {
            console.log('Valid');
        }
        if(this.subjectValue && this.descriptionValue && this.ccValue)
        {
            CreateCases({
                Priority: this.priorityValue,
                Subject: this.subjectValue,
                Description: this.descriptionValue
            }).then(result => {
                console.log('Result' + result);
                if(this.filesData.length >0)
                {
                    this.UploadMultipleFiles(result);
                }
                else{
                    let message = "Record created successfully";
                    const msg = new ShowToastEvent({title:"Success", message:message,variant:"success",mode:"dismissable"});
                    this.dispatchEvent(msg);
                    const newRecordCreated= new CustomEvent("newrecordcreated",{
                        detail: 'result'
                    });
                    this.dispatchEvent(newRecordCreated);
                    this.isModalOpen = false;
                    this.closePopup();
                    this.clearId();
                }
            }).catch(error => {
                if(error && error.body && error.body.message) {
                    const msg = new ShowToastEvent({title:error.body.message, message:'',variant:"error",mode:"dismissable"});
                    this.dispatchEvent(msg);
                    this.isModalOpen = false;
                    this.closePopup();
                    this.clearId();
                }
            })
        }
    }

    
    handleFileUploaded(event) {
        if (event.target.files.length > 0) {
            for(var i=0; i< event.target.files.length; i++){
                if (event.target.files[i].size > 2000000) //Checking if file size is more than 20 MB
                {
                    let message = "File size should not be more than 20 MB";
                    const msg = new ShowToastEvent({title:message, message:'',variant:"error",mode:"dismissable"});
                    this.dispatchEvent(msg);
                    return;
                }
                let file = event.target.files[i];
                let reader = new FileReader();
                reader.onload = e => {
                    var fileContents = reader.result.split(',')[1]
                    this.filesData.push({'fileName':file.name, 'fileContent':fileContents});
                };
                reader.readAsDataURL(file);
            }
        }
    }
 
    UploadMultipleFiles(recordId) {
        if(this.filesData == [] || this.filesData.length == 0) {
            let message = "Please select files first";
            const msg = new ShowToastEvent({title:message, message:'',variant:"error",mode:"dismissable"});
            this.dispatchEvent(msg);
            return;
        }
        this.showSpinner = true;
        UploadMultipleFiles({
            recordId : recordId,
            filedata : JSON.stringify(this.filesData)
        })
        .then(result => {
            console.log(result);
            if(result && result == 'success') {
                this.filesData = [];
                let message = "Record created successfully";
                const msg = new ShowToastEvent({title:"Success", message:message,variant:"success",mode:"dismissable"});
                this.dispatchEvent(msg);
                const newRecordCreated= new CustomEvent("newrecordcreated",{
                    detail: 'result'
                });
                this.dispatchEvent(newRecordCreated);
                this.isModalOpen = false;
                this.closePopup();
                this.clearId();
            } else {
                this.isModalOpen = false;
                this.closePopup();
                this.clearId();
                const msg = new ShowToastEvent({title:error.body.message, message:'',variant:"error",mode:"dismissable"});
                this.dispatchEvent(msg);
            }
        }).catch(error => {
            if(error && error.body && error.body.message) {
                this.isModalOpen = false;
                this.closePopup();
                this.clearId();
                const msg = new ShowToastEvent({title:error.body.message, message:'',variant:"error",mode:"dismissable"});
                this.dispatchEvent(msg);
            }
        }).finally(() => this.showSpinner = false );
    }
 
    removeReceiptImage(event) {
        var index = event.currentTarget.dataset.id;
        this.filesData.splice(index, 1);
    }
}