package servlet;

import javax.servlet.http.HttpServletRequest;

/**
 * A Request represents an HTTP request from
 * the client. There are two kinds of requests:
 * initial requests that start a new session,
 * and requests that are part of an existing session.
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
	boolean startsSession() {
		String session_name = request.getParameter("session");
		Session session = findSession(session_name)
		  catch (BadSession e) {
		  	return false;		  
		  }
	}
}
