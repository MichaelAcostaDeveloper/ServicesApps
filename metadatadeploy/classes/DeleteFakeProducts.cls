/**
 * @author            : Fernando M. Acosta P.
 * @Equipo            : CRM
 * @last modified on  : 02-15-2024
 * @last modified by  : Fernando M. Acosta P.
 * @Descripción       : Clase apex para borrar registros del objeto: Fake_Product__c
**/
public with sharing class DeleteFakeProducts {
    public static void deleteFakeProduts(){
        List<Fake_Product__c> fakeProductToDelete = [SELECT ID FROM Fake_Product__c ];
        delete fakeProductToDelete;
    }
}

//Esta clase se invoca
//DeleteFakeProducts.deleteFakeProduts();