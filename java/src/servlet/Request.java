package servlet;

import javax.servlet.http.HttpServletRequest;

/**
 * A Request represents an HTTP request from
 * the client. There are two kinds of requests:
 * initial requests that start a new session,
 * and requests that are part of an existing session.
 */
public class Request {
	Servlet servlet;
	HttpServletRequest request;
	public Request(Servlet srv, HttpServletRequest req) {
		servlet = srv;
		request = req;
	}
	public String getParam(Input inp) {
		String name = inp.getName();
		return request.getParameter(name);
	}
	public String action() {
		return request.getParameter("do");
	}
	/** Return the associated session, or null if there is none. */
	public Session session() {
		String session_name = request.getParameter("session");
		if (session_name == null) return null;
		try {
			return servlet.findSession(session_name);
		} catch (SessionNotFound exc) {
			return null;
		}
	}
	public HttpServletRequest expose() {
		return request;
	}
}
