import { LightningElement,track } from 'lwc';
import addDigits from '@salesforce/apex/showDatainGrid.addDigits';

export default class AddTwoDigits extends LightningElement {
    @track frstDigit;
    @track scndDigit;
    @track total;

    getResult(){
        addDigits({firstDigit:this.frstDigit,secondDigit:this.scndDigit})
        .then(result=>{
            this.total=result;
        })
        .catch(error=>{
            this.total=undefined;
        })
    }

    setValues(event){
        if(event.target.name=='firstDigit')
        {
            this.frstDigit=event.target.value;
        }
        else if(event.target.name=='secondDigit')
        {
            this.scndDigit=event.target.value;
        }
    }
}