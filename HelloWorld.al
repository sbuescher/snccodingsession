// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50130 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        uri: text;
        responseText: Text;
    begin
        uri := 'https://prod-35.westeurope.logic.azure.com:443/workflows/214d9147f16f4b6fa8ec3dc25cb30ea2/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=ReTCmCILrDKvXs93cnP2l-UonWwZM48ZusvnWGBHAVM';
        Message('App published: Hello world');



        // Add the payload to the content
        content.WriteFrom('{ "name":"John43y" }');

        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

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

    end;
}