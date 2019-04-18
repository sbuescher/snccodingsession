codeunit 50201 "Xml Creation in AL"
{
    trigger OnRun()
    begin

    end;

    procedure CreateXmlRequestContent(): Text
    var
        Doc: XmlDocument;
        header: XmlElement;
        DocElement: XmlElement;
        Archive: XmlElement;
        dateNode: XmlElement;
        descNode: XmlElement;
        Document: XmlElement;
        XmlDecl: XmlDeclaration;
        Attribute: XmlAttribute;
        TempBlob: Record TempBlob;
        FileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        Text9019: Label 'xml files (*.xml)|*.xml|All files (*.*)|*.*';
    begin
        // Create XmlDoc with Xml Declaration
        Doc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'utf-8', '');
        Doc.SetDeclaration(XmlDecl);

        // Create Node
        Archive := XmlElement.Create('archive', GetUri('xmlns'));

        // Version = 5.0
        Attribute := XmlAttribute.Create('version', '5.0');
        Archive.Add(Attribute);

        // generatingSystem = DATEV Musterdaten
        Attribute := XmlAttribute.Create('generatingSystem', 'DATEV Musterdaten');
        Archive.Add(Attribute);

        // xmlns:xsi = http://www.w3.org/2001/XMLSchema-instance
        Attribute := XmlAttribute.CreateNamespaceDeclaration('xsi', GetUri('xsi'));
        Archive.Add(Attribute);

        // xsi:schemaLocation = http://xml.datev.de/bedi/tps/document/v05.0 document_v050.xsd
        Attribute := XmlAttribute.Create('schemaLocation', GetUri('xsi'), GetUri('schemaLocation'));
        Archive.Add(Attribute);

        // header
        header := XmlElement.Create('header', GetUri('xmlns'));

        // date + description
        dateNode := XmlElement.Create('date', GetUri('xmlns'), '2018-01-04T16:21:53');
        descNode := XmlElement.Create('description', GetUri('xmlns'), 'Musterrechnungen');
        header.Add(dateNode);
        header.Add(descNode);
        Archive.Add(header);

        // Add Nodes to Document
        Doc.Add(Archive);

        // Create Stream to download Xml (Xml Declaration is Missing in Message)
        TempBlob.Blob.CreateOutStream(OutStr);
        Doc.WriteTo(OutStr);
        TempBlob.Blob.CreateInStream(InStr, TextEncoding::Windows);
        FileName := 'xmlTest.xml';
        DownloadFromStream(InStr, '', '', Text9019, FileName);

        // Warning: Xml Declaration is Missing in Message
        Doc.GetRoot(DocElement);
        exit(format(DocElement));
    end;

    local procedure GetUri(Value: Text): Text
    begin
        case Value of
            'xsi':
                exit('http://www.w3.org/2001/XMLSchema-instance');
            'xmlns':
                exit('http://xml.datev.de/bedi/tps/document/v05.0');
            'schemaLocation':
                exit('http://xml.datev.de/bedi/tps/document/v05.0 document_v050.xsd');
            else
                ERROR('Unknown Namespace Prefix %1', Value)
        end;
    end;
}