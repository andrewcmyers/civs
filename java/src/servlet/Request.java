package servlet;

import javax.servlet.http.HttpServletRequest;

/**
 * A Request represents an (HTTP) request from
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
    public String remoteAddr() {
        return request.getRemoteAddr();
    }
    public String servletURL() {
        return request.getRequestURL().toString();
        // request.getRequestURL() is equivalent to the string below.
        //return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + request.getServletPath();
    }
    
    public SessionState getSessionState() {        
	SessionState result =
	  (SessionState)request.getSession(true).getAttribute("session_state");

	if (result == null) {
	    result = servlet.createSessionState();
	    request.getSession(true).setAttribute("session_state", result);
	    result.setSessionId(request.getSession().getId());
	}

	return result;
    }
}
