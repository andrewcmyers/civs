package servlet;

import javax.servlet.http.HttpServletRequest;

/**
 * A Request represents an HTTP request from
 * the client.
 */
public class Request {
	HttpServletRequest request;
	public Request(HttpServletRequest req) {
		request = req;
	}
	public String getParam(Input inp) {
		String name = inp.getName();
		return request.getParameter(name);
	}
}
