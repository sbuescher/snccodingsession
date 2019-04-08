codeunit 50200 "Let Me Ship Mgt."
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    procedure CreateXmlRequestContent(): Text
    var
        Doc: XmlDocument;
        Node: XmlNode;
        NamespaceMgt: XmlNamespaceManager;
        Envelope: XmlElement;
        Header: XmlElement;
        Body: XmlElement;
        Security: XmlElement;
        usernameToken: XmlElement;
        apiId: XmlElement;
        apiPassword: XmlElement;
        Attribute: XmlAttribute;
        NameTable: XmlNameTable;
        DocElement: XmlElement;
        bodyText: Text;
        DocBody: XmlDocument;
        ElementBody: XmlElement;
    begin
        Doc := XmlDocument.Create();

        Envelope := XmlElement.Create('Envelope', GetNamespaceUri('soapenv'));
        Attribute := XmlAttribute.CreateNamespaceDeclaration('soapenv', GetNamespaceUri('soapenv'));
        Envelope.Add(Attribute);
        Attribute := XmlAttribute.CreateNamespaceDeclaration('ns3', GetNamespaceUri('ns3'));
        Envelope.Add(Attribute);
        Attribute := XmlAttribute.CreateNamespaceDeclaration('oas', GetNamespaceUri('soapenv'));
        Envelope.add(Attribute);

        Header := XmlElement.Create('Header', GetNamespaceUri('soapenv'));
        Envelope.Add(Header);


        Security := XmlElement.Create('Security', GetNamespaceUri('oas'));
        usernameToken := XmlElement.Create('usernameToken', GetNamespaceUri('oas'));
        apiId := XmlElement.Create('apiId', GetNamespaceUri('oas'), 'test_ID');
        apiPassword := XmlElement.Create('apiPassword', GetNamespaceUri('oas'), 'test_Password');

        Envelope.Add(Header);
        Header.Add(Security);
        Security.Add(usernameToken);
        usernameToken.Add(apiId);
        usernameToken.Add(apiPassword);


        // TODO: Body auslagern

        bodyText := '<soapenv:Body>		<ws:AvailableServicesRequest>			<clientInfo>				<version>2.0</version>				<language>en</language>			</clientInfo>			<pickupAddress>				<countryCode>de</countryCode>				<zip>20140</zip>				<city>Hamburg</city>				<street>Sender street</street>				<company>Sender company</company>				<lastName>Sender</lastName>				<phoneNumber>100100100</phoneNumber>				<phonePrefix>+49</phonePrefix>				<email>alice.sender@sendercompany.xyz</email>			</pickupAddress>			<deliveryAddress>				<countryCode>de</countryCode>				<zip>81920</zip>				<city>Munchen</city>				<street>Receiver street</street>				<lastName>Receiver</lastName>				<phoneNumber>200200200</phoneNumber>				<phonePrefix>49</phonePrefix>			</deliveryAddress>			<shipmentDetails>				<shipmentType>parcel</shipmentType>				<goodsValue>12.50</goodsValue>				<parcels>					<parcel>						<height>40</height>						<width>40</width>						<length>50</length>						<weight>1.5</weight>						<quantity>2</quantity>					</parcel>				</parcels>				<pickupInterval>					<date>2012-09-29</date>					<timeFrom>10:00:00</timeFrom>					<timeTo>16:00:00</timeTo>				</pickupInterval>				<contentDescription>sample content</contentDescription>				<serviceType>express</serviceType>			</shipmentDetails>		</ws:AvailableServicesRequest>	</soapenv:Body>';
        Body := XmlElement.Create('Body', GetNamespaceUri('soapenv'), bodyText);
        Envelope.Add(Body);

        Doc.Add(Envelope);
        doc.GetRoot(DocElement);

        //Message('%1', DocElement);
        exit(format(DocElement));
    end;

    local procedure GetNamespaceUri(Prefix: Text): Text
    begin
        case Prefix of
            'soapenv':
                exit('http://schemas.xmlsoap.org/soap/envelope/');
            'ns3':
                exit('http://v20.shipping.ws.lms.italogistics.com/');
            'oas':
                exit('http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
            else
                ERROR('Unknown Namespace Prefix %1', Prefix)
        end;
    end;
}