package servlet;

import java.util.Date;

import javax.servlet.ServletException;

/**
 * @author andru
 *
 * An Action represents some servlet behavior to be triggered
 * by a user request. An action expects to receive some
 * parameters from the request.
 * 
 * Servlets create subclasses of action to provide
 * request handling.
 * 
 * XXX Actions need some notion of timing out so we can throw them
 * away eventually.
 */
abstract public class Action {
    public final Name name;
    public final String ext_name;
    public final Servlet servlet;
    public final Date sunset;     // when this action expires
    public Action(Servlet s) {
        name = s.nonce.generate();
        ext_name = name.toHex();
        servlet = s;
        sunset = null; // XXX how to decide this?
    }
    public Action(String n, Servlet s) {
        name = null;
        ext_name = n;
        servlet = s;
        sunset = null; // these are permanent
    }
    
    abstract public Page invoke(Request req) throws ServletException;
    
    public String getName() {
        if (name == null) return ext_name;
        return name.toHex();
    }
    
    /**
     * Should the servlet clear all session actions just before invoking this action?
     * The default is true, but subclasses may override on a per-action basis.
     */
    protected boolean clearSessionActionsOnInvoke() {
        return true;
    }
    
    public Servlet getServlet() {
        return servlet;
    }
}
