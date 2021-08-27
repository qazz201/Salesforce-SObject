/**
 * Created by Vladyslav on 8/27/2021.
 */

public with sharing class SObjectMetadata {
    private String sObjectApiName;
    private DescribeFieldResult sObjectFieldDescribe;

    public SObjectMetadata(SObject sobj) {
        this.sObjectApiName = sobj.getSObjectType().getDescribe().getName();
    }

    public SObjectMetadata(Type sobjType) {
        this.sObjectApiName = sobjType.getName();
    }

    public SObjectMetadata(String sobjName) {
        this(Type.forName(sobjName));
    }

    public SObjectMetadata(SObjectField sobjField) {
        this.sObjectFieldDescribe = sobjField.getDescribe();
    }

    ///////////// Object /////////////////////////////////////////////////////////////////////////////////////////////// 
    public String getSObjectApiName() {
        return this.sObjectApiName;
    }

    ///////////// Fields ///////////////////////////////////////////////////////////////////////////////////////////////
    public String getFieldApiName() {
        return this.sObjectFieldDescribe.getName();
    }

    public String getFieldLabel() {
        return this.sObjectFieldDescribe.getLabel();
    }

    public String getFieldType() {
        return this.sObjectFieldDescribe.getType().name();
    }

    public List<String> getFieldPicklistValues() {
        return (List<String>) this.getPicklistEntryValues(this.sObjectFieldDescribe.getPicklistValues(), false);
    }

    public List<PicklistEntryData> getFieldPicklistOptions() {
        return (List<PicklistEntryData>)(Object)this.getPicklistEntryValues(this.sObjectFieldDescribe.getPicklistValues(), true);
    } 


    ///////////// Utility //////////////////////////////////////////////////////////////////////////////////////////////   
    private List<Object> getPicklistEntryValues(List<PicklistEntry> picklistEntries, Boolean grouping) {
        List<Object> result = new List<Object>();

        for (PicklistEntry entry : picklistEntries) {
            if (grouping == true) {
                result.add(new PicklistEntryData(entry));
            } else {
                result.add(entry.getValue());
            }
        }

        return result;
    }


    public class PicklistEntryData {
        @AuraEnabled public Boolean isActive;
        @AuraEnabled public Boolean isDefaultValue;
        @AuraEnabled public String label;
        @AuraEnabled public String value;

        public PicklistEntryData(PicklistEntry picklistEntry) {
            this.isActive = picklistEntry.isActive();
            this.isDefaultValue = picklistEntry.isDefaultValue();
            this.label = picklistEntry.getLabel();
            this.value = picklistEntry.getValue();
        }
    }
}