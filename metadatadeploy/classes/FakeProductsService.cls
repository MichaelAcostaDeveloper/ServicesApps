/**
 * @author            : Fernando M. Acosta P.
 * @Equipo            : CRM
 * @last modified on  : 02-15-2024
 * @last modified by  : Fernando M. Acosta P.
 * @Descripción       : Clase apex para conectAR a un public API
**/
public with sharing class FakeProductsService {
    public static String obtenerFakeProducts(){
        //Creación de una lista de ProductFake para insertar en Salesforce
        List<Fake_Product__c> listProducFake = new List<Fake_Product__c>();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:FakeProducts/api/v1/products');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        //Analizando la respuesta del servidor
        if(res.getStatusCode()!=200){
            System.debug('Error en la conexión!!!');
        }else{
            System.debug(res.getBody());
            Object[] respuestaServidor = (Object[])JSON.deserializeUntyped(res.getBody());
            System.debug('Respuesta deserializada: '+ respuestaServidor);
            for (Object product : respuestaServidor) {
                Map<String,Object> productMap = (Map<String,Object>)product;
                System.debug('VALUES MAP PRODUCTO FAKE>>>> '+ productMap.values());// Se imprimen todos los valores de cada mapa
                System.debug('KEYS MAP PRODUCTO FAKE>>>>> '+productMap.keySet());// Se imprimen todas las key de cada mapa
                //Instancia del objeto ProductFake
                Fake_Product__c objProdFake = new Fake_Product__c();
                objProdFake.Name = String.valueOf(productMap.get('id'));
                objProdFake.title__c = String.valueOf(productMap.get('title'));
                objProdFake.price__c = Decimal.valueOf(String.valueOf(productMap.get('price')));
                objProdFake.description__c = String.valueOf(productMap.get('description'));
                objProdFake.creationAt__c = Date.valueOf(String.valueOf(productMap.get('creationAt')));
                objProdFake.updatedAt__c = Date.valueOf(String.valueOf(productMap.get('updatedAt')));
                listProducFake.add(objProdFake);

            }
        }
        try {
            upsert listProducFake Id;     // This line upserts the Product Fake list with
                                            // the Name field specified as the 
                                            // field that should be used for matching
                                            // the record that should be upserted. 
        } catch (DmlException e) {
            System.debug(e.getMessage());
        }
        return res.getBody();
    }
}

//Esta clase se invoca
//FakeProductsService.obtenerFakeProducts();