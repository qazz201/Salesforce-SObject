/**
 * Created by Vladyslav on 8/30/2021.
 */

public with sharing class SObjectMetadataInfo {
    private DescribeSObjectResult sObjectDescribe;

    public SObjectMetadataInfo(SObject sobj) {
        this.sObjectDescribe = sobj.getSObjectType().getDescribe();
    }

    public SObjectMetadataInfo(Type sobjType) {
        this.setSObjectDescribe(sobjType.getName());
    }

    public SObjectMetadataInfo(String sobjName) {
        this.setSObjectDescribe(sobjName);
    }

    ///////////// Methods //////////////////////////////////////////////////////////////////////////////////////////////
    public String getApiName() {
        return this.sObjectDescribe.getName();
    }

    public Boolean isCustom() {
        return this.sObjectDescribe.isCustom();
    }

    public Boolean isDeletable() {
        return this.sObjectDescribe.isDeletable();
    }

    public Boolean isUndeletable() {
        return this.sObjectDescribe.isUndeletable();
    }

    public Boolean isQueryable() {
        return this.sObjectDescribe.isQueryable();
    }

    public Boolean isUpdateable() {
        return this.sObjectDescribe.isUpdateable();
    }

    public String getNameSpace() {
        String apiName = this.getApiName();
        Integer namespaceEndPosition = apiName.replace('__c', '').indexOf('__');

        return namespaceEndPosition > 0 ? apiName.substring(0, namespaceEndPosition) : null;
    }

    public List<String> getFieldsApiNameList() {
        List<SObjectField> fields = this.sObjectDescribe.fields.getMap().values();
        List<String> result = new List<String>();

        for (SObjectField field : fields) result.add(String.valueOf(field));

        return result;
    }

    ///////////// Utility //////////////////////////////////////////////////////////////////////////////////////////////
    private void setSObjectDescribe(String sObjectApiName) {
        try {
            this.sObjectDescribe = Schema.getGlobalDescribe().get(sObjectApiName).getDescribe();
        } catch (Exception e) {
            throw new SObjectMetadataInfoException('No such SObject: ' + sObjectApiName);
        }
    }

    public class SObjectMetadataInfoException extends Exception {
    }
}