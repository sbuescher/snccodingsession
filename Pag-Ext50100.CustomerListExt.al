// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 "CustomerListExt" extends "Customer List"
{
    trigger OnOpenPage();
    var
        AvailableServices: Codeunit 50201;
        CreateShipment: Codeunit 50202;
    begin
        //AvailableServices.CallAvailableServicesRequest();
        CreateShipment.CallCreateShipmentRequest();
        /*
        //Message('App published: Hello world');

        //requestXml := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:oas="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:ws="http://v20.shipping.ws.lms.italogistics.com/">	<soapenv:Header>		<oas:Security>			<oas:usernameToken>				<oas:apiId>paUyFcmBb2bGAALbDOLUYE33EcUwpQFY</oas:apiId>				<oas:apiPassword>U2ZVXqRm1Ky+JL76SoN+JM9xow!vBUtB</oas:apiPassword>			</oas:usernameToken>		</oas:Security>	</soapenv:Header>	<soapenv:Body>		<ws:AvailableServicesRequest>			<clientInfo>				<version>2.0</version>				<language>en</language>			</clientInfo>			<pickupAddress>				<countryCode>de</countryCode>				<zip>20140</zip>				<city>Hamburg</city>				<street>Sender street</street>				<company>Sender company</company>				<lastName>Sender</lastName>				<phoneNumber>100100100</phoneNumber>				<phonePrefix>+49</phonePrefix>				<email>alice.sender@sendercompany.xyz</email>			</pickupAddress>			<deliveryAddress>				<countryCode>de</countryCode>				<zip>81920</zip>				<city>Munchen</city>				<street>Receiver street</street>				<lastName>Receiver</lastName>				<phoneNumber>200200200</phoneNumber>				<phonePrefix>49</phonePrefix>			</deliveryAddress>			<shipmentDetails>				<shipmentType>parcel</shipmentType>				<goodsValue>12.50</goodsValue>				<parcels>					<parcel>						<height>40</height>						<width>40</width>						<length>50</length>						<weight>1.5</weight>						<quantity>2</quantity>					</parcel>				</parcels>				<pickupInterval>					<date>2019-05-08</date>					<timeFrom>10:00:00</timeFrom>					<timeTo>16:00:00</timeTo>				</pickupInterval>				<contentDescription>sample content</contentDescription>				<serviceType>express</serviceType>			</shipmentDetails>		</ws:AvailableServicesRequest>	</soapenv:Body></soapenv:Envelope>';
        requestXml := LetMeShipMgt.CreateXmlRequestContent();

        // Message(requestXml);
        // exit;

        uri := 'https://de-sandbox.test.letmeship.com/LMS2_ws/shipping/v2_0';

        // Add the payload to the content
        content.WriteFrom(requestXml);

        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'text/xml');

        // Assigning content to request.Content will actually create a copy of the content and assign it.
        // After this line, modifying the content variable or its associated headers will not reflect in 
        // the content associated with the request message
        request.Content := content;

        request.SetRequestUri(uri);
        request.Method := 'POST';

        client.Send(request, response);

        // Read the response content as json.
        response.Content().ReadAs(responseText);
        Message(Format(response.HttpStatusCode()));
        content := response.Content();
        content.ReadAs(resultText);
        Message(resultText);

        XmlDocument.ReadFrom(resultText, XmlDoc);
        NamespaceMgt.AddNamespace('S', 'http://schemas.xmlsoap.org/soap/envelope/');
        NamespaceMgt.AddNamespace('ns3', 'http://v20.shipping.ws.lms.italogistics.com/');

        XmlDoc.SelectSingleNode('/S:Envelope/S:Body/ns3:AvailableServicesResponse', NamespaceMgt, Node);

        Element := Node.AsXmlElement();
        Message('%1', Element.InnerXml());
        */
    end;
}