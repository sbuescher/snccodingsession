codeunit 50201 "Available Services"
{
    procedure CallAvailableServicesRequest(): Text
    var
        Node: XmlElement;
        Body: XmlElement;
        AvailableServicesRequest: XmlElement;
        XmlChild: XmlElement;
        Element: XmlElement;
        ShipmentDetails: XmlElement;
        Parcels: XmlElement;
        LetMeShipMgt: Codeunit 50200;
        result: Text;
    begin
        Body := LetMeShipMgt.CreateNode('Body', 'soapenv');
        AvailableServicesRequest := LetMeShipMgt.CreateNode('AvailableServicesRequest', 'ws');

        // clientInfo
        Node := LetMeShipMgt.CreateNode('clientInfo', '');
        LetMeShipMgt.AddChild(Node, 'version', '', '2.0');
        LetMeShipMgt.AddChild(Node, 'language', '', 'en');
        AvailableServicesRequest.Add(Node);

        // pickupAddress
        Node := LetMeShipMgt.CreateNode('pickupAddress', '');
        LetMeShipMgt.AddChild(Node, 'countryCode', '', 'de');
        LetMeShipMgt.AddChild(Node, 'zip', '', '20140');
        LetMeShipMgt.AddChild(Node, 'city', '', 'Hamburg');
        LetMeShipMgt.AddChild(Node, 'street', '', 'Sender Street');
        LetMeShipMgt.AddChild(Node, 'company', '', 'SenderCompany');
        LetMeShipMgt.AddChild(Node, 'lastName', '', 'Sender');
        LetMeShipMgt.AddChild(Node, 'phoneNumber', '', '100100100');
        LetMeShipMgt.AddChild(Node, 'phonePrefix', '', '+49');
        LetMeShipMgt.AddChild(Node, 'email', '', 'alice.sender@sendercompany.xyz');
        AvailableServicesRequest.Add(Node);

        // deliveryAddress
        Node := LetMeShipMgt.CreateNode('deliveryAddress', '');
        LetMeShipMgt.AddChild(Node, 'countryCode', '', 'de');
        LetMeShipMgt.AddChild(Node, 'zip', '', '81920');
        LetMeShipMgt.AddChild(Node, 'city', '', 'Munchen');
        LetMeShipMgt.AddChild(Node, 'street', '', 'Receiver Street');
        LetMeShipMgt.AddChild(Node, 'lastName', '', 'Receiver');
        LetMeShipMgt.AddChild(Node, 'phoneNumber', '', '200200200');
        LetMeShipMgt.AddChild(Node, 'phonePrefix', '', '+49');
        AvailableServicesRequest.Add(Node);

        // shipmentDetails
        ShipmentDetails := LetMeShipMgt.CreateNode('shipmentDetails', '');
        LetMeShipMgt.AddChild(ShipmentDetails, 'shipmentType', '', 'parcel');
        LetMeShipMgt.AddChild(ShipmentDetails, 'goodsValue', '', '12.50');

        // parcels
        Parcels := LetMeShipMgt.CreateNode('parcels', '');
        Node := LetMeShipMgt.CreateNode('parcel', '');
        LetMeShipMgt.AddChild(Node, 'height', '', '40');
        LetMeShipMgt.AddChild(Node, 'width', '', '40');
        LetMeShipMgt.AddChild(Node, 'length', '', '50');
        LetMeShipMgt.AddChild(Node, 'weight', '', '1.5');
        LetMeShipMgt.AddChild(Node, 'quantity', '', '2');
        Parcels.Add(Node);
        ShipmentDetails.Add(Parcels);

        // pickupInterval
        Node := LetMeShipMgt.CreateNode('pickupInterval', '');
        LetMeShipMgt.AddChild(Node, 'date', '', '2019-05-08');
        LetMeShipMgt.AddChild(Node, 'timeFrom', '', '10:00:00');
        LetMeShipMgt.AddChild(Node, 'timeTo', '', '16:00:00');
        ShipmentDetails.Add(Node);

        LetMeShipMgt.AddChild(ShipmentDetails, 'contentDescription', '', 'sample content');
        LetMeShipMgt.AddChild(ShipmentDetails, 'serviceType', '', 'express');

        AvailableServicesRequest.Add(ShipmentDetails);

        Body.Add(AvailableServicesRequest);

        result := LetMeShipMgt.SendMessage(Body);
        Message(result);
    end;
}