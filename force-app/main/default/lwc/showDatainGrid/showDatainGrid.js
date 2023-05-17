import { LightningElement,track,wire } from 'lwc';
import GetAccounts from '@salesforce/apex/showDatainGrid.GetAccounts';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class ShowDatainGrid extends LightningElement {
    @track allData;
    @track columns=[
        {
            label: 'Name', fieldName: 'Name', type: 'text'
        },
        {
            label: 'Phone', fieldName: 'Phone', type: 'phone'
        },
        {
            label: 'Email', fieldName: 'Email', type: 'email'
        }
    ];
    @wire (GetAccounts) AccountRecords(data,error)
    {
        console.log(data);
        console.log(error);
        if(data)
        {
            console.log('data');
            this.allData=data.data;
        }
        else if(error)
        {
            console.log('response');
            console.log(error);
            this.allData=undefined;
        }
    }
}