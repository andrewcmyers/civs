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
	public String action_name() {
		return request.getParameter("action");
	}
	public String request_name() {
		return request.getParameter("request");
	}
	
	/** Return the associated session, or null if there is none.
	 * Initial requests do not reference a session. 
	public servlet.Session session() throws SessionNotFound {
		String session_name = request.getParameter("session");
		if (session_name == null) return null;
		return servlet.findSession(session_name);
	}
	
	public HttpServletRequest expose() {
		return request;
	}
	*/
}
