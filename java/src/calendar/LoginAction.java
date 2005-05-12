package calendar;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;

import servlet.*;

public class LoginAction extends CalendarAction {
    final private Action successAction;
    
    private InputNode inpUserID;
    private InputNode inpPassword = new PasswordInput(getServlet(), 40, "");
    
    public LoginAction(Main servlet, Action successAction) {
        super(servlet);
        this.successAction = successAction;
        
        this.recreateInputs(null);
    }

    public Page invoke(Request req) throws ServletException {
        // when this action is invoked, produce the page.
        return producePage(req, null);
    }
        
    private class SubmitLoginAction extends CalendarAction {
        public SubmitLoginAction(Main s) {
            super(s);
        }
        
        public Page invoke(Request req) throws ServletException {
            // user has submitted username and password.
            
            // extract data from request
            String userID = req.getParam(inpUserID);
            String password = req.getParam(inpPassword);

            // now that we have retreived the data we need, recreate the inputs
            // which overwrites the input nodes. Do it now, so that
            // the keys of the hashmap are correct.            
            recreateInputs(req);
            
            // validate data
            
            HashMap errors = new HashMap();

            // @@@@ would check against a database here.
            User loginUser = (User)main.cal.users.get(userID);
            if (userID == null || userID.length() == 0) {
                // invalid user ID
                errors.put(inpUserID, "Invalid user ID.");                
            }
            else if (password == null || password.length() == 0) {
                // invalid password
                errors.put(inpPassword, "Please enter a password.");                
            }
            else if (loginUser == null || !password.equals(loginUser.getPassword())) {
                // unknown user or incorrect password 
                errors.put(inpPassword, "Unknown or incorrect username and password.");                
            }
            if (!errors.isEmpty()) {
                return producePage(req, errors);
            }

            // successful login!            
            
            // set the current user in the session state.
            ((CalendarSessionState)req.getSessionState()).currentUser = loginUser;
            
            // send user back to return action.
            return LoginAction.this.successAction.invoke(req);
        }        
    }
        
    private Page producePage(Request req, HashMap errors) {
        String title = "Login to your favourite calendar webapp";
	NodeList entries = new NodeList(new TRow(new NodeList(desc("User ID:"),
	                                inpNode(inpUserID, errors))));
	entries = entries.append(new TRow(new NodeList(desc("Password:"),
		inpNode(inpPassword, errors))));
	entries = entries.append(new TRow(new TCell(new SubmitButton(getServlet(),
				"Login"))));
        Node content = getServlet().createForm(new SubmitLoginAction(main),
                                               req, new Table(null, entries)); 
        
	return getServlet().createPage(title, new NodeList(new Text(title),
	      content));        
    }
    
    // helper methods for producing the output
    private void recreateInputs(Request req) {
        String defaultUserID = "";
        if (req != null) {
            if (req.getParam(inpUserID) != null) {
                defaultUserID = req.getParam(inpUserID); 
            }
        }
        
        this.inpUserID = new TextInput(getServlet(), 40, defaultUserID);
    }

    private Node desc(String txt) {
        Tag n = new TCell(new Text(txt));
        n.setClass("desc");
        return n;
    }
    private Node inpNode(InputNode inp, HashMap errors) {
        TCell cell;
        cell = new TCell(inp);

        if (errors == null || !errors.containsKey(inp)) {
            return cell;
        }
        // There is an error for this input
        TCell err = new TCell(new Text((String)errors.get(inp)));
        err.setClass("error");
        return new NodeList(cell, err);
    }
}
