/**
 * Created by Vladyslav on 8/30/2021.
 */

public with sharing class SObjectMetadataInfo {
    private String sObjectApiName;

    public SObjectMetadataInfo(SObject sobj) {
        this.sObjectApiName = sobj.getSObjectType().getDescribe().getName();
    }

    public SObjectMetadataInfo(Type sobjType) {
        this.sObjectApiName = sobjType.getName();
    }

    public SObjectMetadataInfo(String sobjName) {
        this(Type.forName(sobjName));
    }

    ///////////// Methods //////////////////////////////////////////////////////////////////////////////////////////////
    public String getApiName() {
        return this.sObjectApiName;
    }
}