package calendar;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;

import servlet.*;

public class LogoffAction extends CalendarAction {
    public LogoffAction(Main servlet) {
        super("logoff", servlet);
    }

    public Page invoke(Request req) throws ServletException {
        // invalidate the session.
        CalendarSessionState state = (CalendarSessionState)req.getSessionState();
        state.currentUser = null;
        req.invalidateSession();
        
        return producePage(req);
    }
        
        
    private Page producePage(Request req) {
        String title = "Goodbye";
        NodeList content = new NodeList(new Paragraph(new Text("You have succesfully logged off the calendar application."))); 
        content = content.append(new Hyperlink(req, main.showCalAction, new Text("Login again"))); 
        
	return getServlet().createPage(title, new NodeList(new Paragraph(new Text(title)),
	      content));        
    }
    
}
