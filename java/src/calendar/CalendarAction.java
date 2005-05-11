package calendar;

import javax.servlet.ServletException;

import servlet.Action;
import servlet.Page;
import servlet.Request;

/**
 * A Calendar-specific Action class.
 */
abstract public class CalendarAction extends Action {
    public final Main main;
    
    public CalendarAction(Main m) {
        super(m);
        this.main = m;
    }
    
    public CalendarAction(String n, Main m) {
        super(n,m);
        this.main = m;
    }
    
    /**
     * Ensure that there is a logged in user. This method should be called first
     * in the invoke() method of any action that requires the user to be logged in.
     * If this method returns a non-null value, the calling action should return that 
     * Page.
     * 
     * @param req the Request
     * @return the login Page if the user is not yet logged in, null if the user
     *         is logged in.
     * @throws ServletException
     */
    protected Page ensureLoggedIn(Request req) throws ServletException {
        if (((CalendarSessionState)req.getSessionState()).currentUser == null) {
            // not logged in yet.
            return new LoginAction(main, this).invoke(req);
        }
        return null;        
    }
}

