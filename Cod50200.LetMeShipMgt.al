codeunit 50200 "Let Me Ship Mgt."
{
    trigger OnRun()
    begin

    end;

    procedure SendMessage(Body: XmlElement) Result: Text
    var
        RequestXml: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        uri: text;
        responseText: Text;
        XmlDoc: XmlDocument;
        Nodelist: XmlNodeList;
        Node: XmlNode;
        Element: XmlElement;
    begin
        RequestXml := CreateMessage(Body);
        uri := 'https://de-sandbox.test.letmeship.com/LMS2_ws/shipping/v2_0';

        content.WriteFrom(requestXml);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'text/xml');

        request.Content := content;
        request.SetRequestUri(uri);
        request.Method := 'POST';
        client.Send(request, response);

        response.Content().ReadAs(responseText);
        Message(Format(response.HttpStatusCode()));
        content := response.Content();
        content.ReadAs(Result);
    end;

    procedure GetNamespaceUri(Prefix: Text): Text
    begin
        if Prefix <> '' then
            case Prefix of
                'soapenv':
                    exit('http://schemas.xmlsoap.org/soap/envelope/');
                'ws':
                    exit('http://v20.shipping.ws.lms.italogistics.com/');
                'oas':
                    exit('http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                else
                    ERROR('Unknown Namespace Prefix %1', Prefix)
            end;
    end;

    procedure CreateNode(Name: Text; NamespaceName: Text) Element: XmlElement
    begin
        Element := XmlElement.Create(Name, GetNamespaceUri(NamespaceName));
    end;

    procedure AddChild(ParentNode: XmlElement; Name: Text; NamespaceName: Text; Content: Text)
    begin
        ParentNode.Add(XmlElement.Create(Name, GetNamespaceUri(NamespaceName), Content));
    end;

    procedure CreateMessage(Body: XmlElement) Request: Text
    var
        Envelope: XmlElement;
        Doc: XmlDocument;
        DocElement: XmlElement;
    begin
        Envelope := CreateMessageEnvelope();
        Envelope.Add(CreateMessageHeader());
        Envelope.Add(Body);

        Doc := XmlDocument.Create();
        Doc.Add(Envelope);
        doc.GetRoot(DocElement);
        Message(Format(DocElement));
        exit(format(DocElement));
    end;

    local procedure CreateMessageEnvelope() Envelope: XmlElement
    var
        Attribute: XmlAttribute;
    begin
        Envelope := CreateNode('Envelope', 'soapenv');
        Attribute := XmlAttribute.CreateNamespaceDeclaration('soapenv', GetNamespaceUri('soapenv'));
        Envelope.Add(Attribute);
        Attribute := XmlAttribute.CreateNamespaceDeclaration('ws', GetNamespaceUri('ws'));
        Envelope.Add(Attribute);
        Attribute := XmlAttribute.CreateNamespaceDeclaration('oas', GetNamespaceUri('oas'));
        Envelope.Add(Attribute);
    end;

    local procedure CreateMessageHeader() Header: XmlElement
    var
        Security: XmlElement;
        usernameToken: XmlElement;
    begin
        Header := CreateNode('Header', 'soapenv');
        Security := CreateNode('Security', 'oas');
        usernameToken := CreateNode('usernameToken', 'oas');
        AddChild(usernameToken, 'apiId', 'oas', 'paUyFcmBb2bGAALbDOLUYE33EcUwpQFY');
        AddChild(usernameToken, 'apiPassword', 'oas', 'U2ZVXqRm1Ky+JL76SoN+JM9xow!vBUtB');
        Security.Add(usernameToken);
        Header.Add(Security);
    end;

    procedure AddAttribute(VAR Node: XmlElement; AttributeName: Text; AttributeValue: Text)
    var
        Attribute: XmlAttribute;
    begin
        Attribute := XmlAttribute.Create(AttributeName, AttributeValue);
        Node.Add(Attribute);
    end;
}