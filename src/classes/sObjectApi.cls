/**
 * Created by Vladyslav on 8/27/2021.
 */

public with sharing class sObjectApi {

    public static String getSObjectName(SObject sobj) {
        return sobj.getSObjectType().getDescribe().getName();
    }

    public static String getSObjectName(String sobjName) {
        return getSObjectName(Type.forName(sobjName));
    }

    public static String getSObjectName(Type sobjType) {
        return sobjType.getName();
    }

    public static String getSObjectFieldName(SObjectField sobjField) {
        return getFieldDescribe(sobjField).getName();
    }

    public static String getSObjectFieldLabel(SObjectField sobjField) {
        return getFieldDescribe(sobjField).getLabel();
    }

    public static String getSObjectFieldType(SObjectField sobjField) {
        return String.valueOf(getFieldDescribe(sobjField).getType());
    }

    public static List<String> getSObjectFieldPicklistValues(SObjectField sobjField) {
        List<PicklistEntry> picklistEntries = getFieldDescribe(sobjField).getPicklistValues();
        List<String> result = new List<String>();

        for (PicklistEntry entry : picklistEntries) {
            result.add(entry.getValue());
        }

        return result;
    }


    private static DescribeFieldResult getFieldDescribe(SObjectField sobjField) {
        return sobjField.getDescribe();
    }
}