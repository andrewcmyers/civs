package servlet;

/**
 * Global state for a single session.
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
    
    public SessionPrincipal getSessionPrincipal() {
        if (sessionPrincipal == null) {
            sessionPrincipal = new SessionPrincipal(this);
        }
        return sessionPrincipal;
    }
    
    void setSessionId(String id) {
        this.sessionId = id;
    }
    public String getSessionId() {
        return this.sessionId;
    }
}

