package servlet;

/**
 * Global state for a single session.
 */

public abstract class SessionState {
    /**
     * Principal representing this session.
     */
    private SessionPrincipal sessionPrincipal;
    
    /**
     * String that uniquely identifies this session. 
     */
    private String sessionId;
    
    /**
     * The Request currently being processed.
     * XXX@@@ This should maybe be a ThreadLocal, to allow
     * correct functioning when there are multiple concurrent
     * requests in the same session.
     */
    private Request currRequest;
    
    Request getCurrentRequest() {
        return currRequest;
    }
    void setCurrentRequest(Request req) {
        this.currRequest = req;
    }

    public SessionPrincipal getSessionPrincipal() {
        return sessionPrincipal;
    }
    void setSessionPrincipal(SessionPrincipal sessionPrincipal ) {
        this.sessionPrincipal = sessionPrincipal;
    }
    void setSessionId(String id) {
        this.sessionId = id;
    }
    public String getSessionId() {
        return this.sessionId;
    }
}

