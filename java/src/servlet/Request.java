package servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
    public String title() {
        return request.getParameter("title");
    }
    public String servletURL() {
        return request.getRequestURL().toString();
        // request.getRequestURL() is equivalent to the string below.
        //return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + request.getServletPath();
    }
    /**
     * Return the SecurityPrincipal representing the session.
     */
    public SessionPrincipal getSessionPrincipal() {
        SessionPrincipal p = getSessionState().getSessionPrincipal();
        if (p == null) {
            p = new SessionPrincipal(getSessionState());
            getSessionState().setSessionPrincipal(p);
        }
        return p;
    }
    
    public boolean isRemoteUserAuthenticated() {
        return request.getRemoteUser() != null;
    }
    /**
     * Return the Principal representing the remote user.
     * @throws NoAuthenticatedUser if currently no authenticated
     * remote user
     */
    public SecurityPrincipal getRemoteUserPrincipal() throws NoAuthenticatedUser {
        String remote = request.getRemoteUser();
        if (remote == null) {
            throw new NoAuthenticatedUser();            
        }
        final SessionState sess = getSessionState();
        UserRoleChecker c = new UserRoleChecker() {
            private SessionState ss = sess;
            public boolean isUserInRole(UserPrincipal u, RolePrincipal r) {
                Request rq = ss.getCurrentRequest();
                if (u.name().equals(rq.request.getRemoteUser())) {
                    return rq.request.isUserInRole(r.name());
                }
                return false;
            }
        };
        return new UserPrincipal(remote, c);
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
