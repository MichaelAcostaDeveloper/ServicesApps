/**
 * @author            : Fernando M. Acosta P.
 * @Equipo            : CRM
 * @last modified on  : 02-09-2024
 * @last modified by  : Fernando M. Acosta P.
 * @Descripción       : Componente o clase apex ...
**/
public with sharing class FakeProductsService {
    public static String obtenerFakeProducts(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:FakeProducts/api/v1/products');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return res.getBody();
    }
}