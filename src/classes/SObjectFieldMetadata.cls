/**
 * Created by Vladyslav on 8/27/2021.
 */

public with sharing class SObjectFieldMetadata {
    private DescribeFieldResult sObjectFieldDescribe;

    public SObjectFieldMetadata(SObjectField sobjField) {
        this.sObjectFieldDescribe = sobjField.getDescribe();
    }


    ///////////// Methods //////////////////////////////////////////////////////////////////////////////////////////////
    public String getFieldApiName() {
        return this.sObjectFieldDescribe.getName();
    }

    public String getFieldLabel() {
        return this.sObjectFieldDescribe.getLabel();
    }

    public String getFieldType() {
        return this.sObjectFieldDescribe.getType().name();
    }

    public List<PicklistEntryData> getFieldPicklistOptions() {
        List<PicklistEntryData> result = new List<PicklistEntryData>();

        for (PicklistEntry entry : this.sObjectFieldDescribe.getPicklistValues()) {
            result.add(new PicklistEntryData(entry));
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

    public class SObjectFieldMetadataException extends Exception {
    }
}