import { LightningElement,track,api } from 'lwc';

export default class MessageComponent extends LightningElement {
    @api isDeleteModelOpen = false;
    @api messageString = '';
    @api messageHeading = '';
    @api rowId;

    closeModal()
    {
        this.isDeleteModelOpen = false;
    }

    submitDetails()
    {
        const confirmation = new CustomEvent("gotconfirmation",{
            detail : this.isDeleteModelOpen
        })
        this.dispatchEvent(confirmation);
    }
}