package servlet;

import javax.servlet.http.HttpServletRequest;

/**
 * A Request represents an HTTP request from
 * the client. There are two kinds of requests:
 * initial requests that start a new session,
 * and requests that are part of an existing session.
 */
public final class Request {
	public final Servlet servlet;
	HttpServletRequest request;
	public Request(Servlet srv, HttpServletRequest req) {
		servlet = srv;
		request = req;
	}
	public String getParam(Input inp) {
		String name = inp.getName();
		return request.getParameter(name);
	}
	public String getParam(InputNode n) {
		return getParam(n.input);
	}
	public String action_name() {
		return request.getParameter("action");
	}
	public String request_name() {
		return request.getParameter("request");
	}
	public String title() {
		return request.getParameter("title");
	}
	public String servlet_url() {
		return request.getServletPath();
	}
}
