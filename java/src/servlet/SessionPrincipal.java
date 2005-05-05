package servlet;

/**
 * A session principal. This principal represents an HTTP session.
 */
public class SessionPrincipal extends SecurityPrincipal {
    final SessionState session;
    SessionPrincipal(SessionState session) {
        this.session = session;
    }
    
    public String name() {
        return session.getSessionId();
    }

    public boolean actsFor(SecurityPrincipal principal) {
        if (this.equals(principal)) return true;
        SecurityPrincipal u = session.getSessionPrincipal();
        if (u != null) {
            return u.actsFor(principal);
        }
        return false;
    }    
}
