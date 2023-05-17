public with sharing class GetCaseData {
    // @AuraEnabled(cacheable=true)
    // public static List<Case> getCaseList() {
    //     //List<CaseRelatedIssue> cases = new List<CaseRelatedIssue>();
    //     //cases = [Select CaseId,Name from CaseRelatedIssue];
    //     return [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority FROM Case ];
    // }

    @AuraEnabled//Get Cases Records
    public static String getCaseList(Integer pageSize, Integer pageNumber){
        String jsonDT = '';
         
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Case];
        Integer recordEnd = pageSize * pageNumber;
         
        CaseDTWrapper objDT =  new CaseDTWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.cases = [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority,LastModifiedDate FROM Case order by LastModifiedDate Desc LIMIT :pageSize OFFSET :offset];
        jsonDT = JSON.serialize(objDT);
        return jsonDT;
    }

    @AuraEnabled//Get Filterred Cases Records
    public static string filterCases(String Status, String Priority, Integer pageSize, Integer pageNumber){
        try {
            String jsonDT = '';
             
            //Offset for SOQL
            Integer offset = (pageNumber - 1) * pageSize;
             
             
            CaseDTWrapper objDT =  new CaseDTWrapper();  
            objDT.pageSize = pageSize;
            objDT.pageNumber = pageNumber;
            objDT.recordStart = offset + 1;
            if(string.isBlank(Status) && string.isBlank(Priority))
            {
                objDT.cases = [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority,LastModifiedDate FROM Case order by LastModifiedDate Desc  LIMIT :pageSize OFFSET :offset];
                
                //Total Records
                Integer totalRecords = [SELECT COUNT() FROM Case];
                Integer recordEnd = pageSize * pageNumber;
                objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
                jsonDT = JSON.serialize(objDT);
                return jsonDT;
            }
            else if(string.isBlank(Status))
            {
                string likePriority = '%'+Priority+'%';
                objDT.cases = [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority,LastModifiedDate FROM Case where Priority like :likePriority order by LastModifiedDate Desc  LIMIT :pageSize OFFSET :offset];
                                
                //Total Records
                Integer totalRecords = [SELECT COUNT() FROM Case where Priority like :likePriority];
                Integer recordEnd = pageSize * pageNumber;
                objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
                jsonDT = JSON.serialize(objDT);
                return jsonDT;
            }
            else if(string.isBlank(Priority))
            {
                string likeStatus = '%'+Status+'%';
                objDT.cases = [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority,LastModifiedDate FROM Case where Status like :likeStatus order by LastModifiedDate Desc  LIMIT :pageSize OFFSET :offset];
                                
                //Total Records
                Integer totalRecords = [SELECT COUNT() FROM Case where Status like :likeStatus];
                Integer recordEnd = pageSize * pageNumber;
                objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
                jsonDT = JSON.serialize(objDT);
                return jsonDT;
            }
            else 
            {
                string likePriority = '%'+Priority+'%';
                string likeStatus = '%'+Status+'%';
                objDT.cases = [Select CaseNumber, createdBy.Name,Subject,Status,CreatedDate,Priority,LastModifiedDate FROM Case where Status like :likeStatus and Priority like :likePriority order by LastModifiedDate Desc  LIMIT :pageSize OFFSET :offset];
                                
                //Total Records
                Integer totalRecords = [SELECT COUNT() FROM Case where Status like :likeStatus and Priority like :likePriority];
                Integer recordEnd = pageSize * pageNumber;
                objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                objDT.totalRecords = totalRecords;
                jsonDT = JSON.serialize(objDT);
                return jsonDT;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<sObject> getStatusValues(){
        try {
            List<sObject> dropdownValues = new List<sObject>();
            dropdownValues = [Select Status FROM Case group by Status];
            return dropdownValues;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<sObject> getPriorityValues(){
        try {
            List<sObject> dropdownValues = new List<sObject>();
            dropdownValues = [Select Priority FROM Case group by Priority];
            return dropdownValues;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
     
    public class CaseDTWrapper {
        public Integer pageSize {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordStart {get;set;}
        public Integer recordEnd {get;set;}
        public List<Case> cases {get;set;}
    }
}