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
        return sobjField.getDescribe().getName();
    }


}