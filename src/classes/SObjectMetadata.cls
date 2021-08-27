/**
 * Created by Vladyslav on 8/27/2021.
 */

public with sharing class SObjectMetadata {

    public static String getName(SObject sobj) {
        return sobj.getSObjectType().getDescribe().getName();
    }

    public static String getName(String sobjName) {
        return getName(Type.forName(sobjName));
    }

    public static String getName(Type sobjType) {
        return sobjType.getName();
    }

    public static String getFieldName(SObjectField sobjField) {
        return getFieldDescribe(sobjField).getName();
    }

    public static String getFieldLabel(SObjectField sobjField) {
        return getFieldDescribe(sobjField).getLabel();
    }

    public static String getFieldType(SObjectField sobjField) {
        return String.valueOf(getFieldDescribe(sobjField).getType());
    }

    public static List<String> getFieldPicklistValues(SObjectField sobjField) {
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