package servlet;

/**
 * Global state for a single session.
 * XXX I made this non-abstract. Not sure why it can't be used as is... --AM
 */

public class SessionState {
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
     * 
     * XXX The whole idea of currRequest seems irredeemably
     * broken to me. Making it thread-local seems like a dangerous
     * hack. --AM
     * 
     * @deprecated
     */
    private Request currRequest;
    
    /** @deprecated */
    Request getCurrentRequest() {
        return currRequest;
    }
    
    /** @deprecated */
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

