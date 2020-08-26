@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock
{
    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Blob bodyAsBlob;
    protected Map<String, String> responseHeaders;
    public MockHttpResponseGenerator (){
        this.code = 200;
        this.status = 'Complete';
        this.bodyAsString = null;
        this.bodyAsBlob = null;
        this.responseHeaders = null;
    }
    public MockHttpResponseGenerator (String body){
        this.code = 200;
        this.status = 'Complete';
        this.bodyAsString = body;
        this.bodyAsBlob = null;
        this.responseHeaders = null;
    }
	public MockHttpResponseGenerator(Integer code, String status, String body,
                                         Map<String, String> responseHeaders) {
		this.code = code;
		this.status = status;
		this.bodyAsString = body;
		this.bodyAsBlob = null;
		this.responseHeaders = responseHeaders;
    }
	public HTTPResponse respond(HTTPRequest req) {
		HttpResponse resp = new HttpResponse();
        resp.setStatusCode(code);
        resp.setHeader('Content-Type', 'application/json');
		resp.setStatus(status);
		if (bodyAsBlob != null) {
			resp.setBodyAsBlob(bodyAsBlob);
		} else {
            resp.setBody(bodyAsString);
            System.debug('bodyAsString: ' + bodyAsString);
		}
		if (responseHeaders != null) {
			 for (String key : responseHeaders.keySet()) {
			    resp.setHeader(key, responseHeaders.get(key));
			 }
		}
		return resp;
    }
}