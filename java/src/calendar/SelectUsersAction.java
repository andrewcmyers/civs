package calendar;

import java.util.*;

import javax.servlet.ServletException;

import servlet.*;

/**
 * Action to select one or more users. The action can be instantiated in
 * either "select single user" mode, or "select user list" mode. The action
 * can be instantiated with a specific message to display, and with a mutable List
 * of Users, in which the selected user(s) will be returned.
 */
public class SelectUsersAction extends CalendarAction {
    private List userList;
    final private boolean singleMode;
    private String message;
    final private Action successAction;
    final private Action cancelAction;
    
    private TextInput inpSingleUser;
    private TextArea inpUsers;
    
    public SelectUsersAction(Main servlet, 
                           Action successAction, 
                           Action cancelAction, 
                           List userList, 
                           boolean singleMode,
                           String message) {
        super(servlet);
        this.successAction = successAction;
        this.cancelAction = cancelAction;
        this.userList = userList;
        this.singleMode = singleMode;
        this.message = message;
        if (this.message == null) {
            if (singleMode) {
                this.message = "Please select a user.";                
            }
            else {
                this.message = "Please select users.";                                
            }
        }

        
        this.recreateInputs(null);
    }

    public List getUserList() {
        return userList;
    }
    
    public Page invoke(Request req) throws ServletException {
        Page loginPage = ensureLoggedIn(req);
        if (loginPage != null) return loginPage;

        // when this action is invoked, produce the page.
        return producePage(req, null);
    }
        
    private class FinshSelectUsers extends CalendarAction {
        public FinshSelectUsers(Main s) {
            super(s);
        }
        
        public Page invoke(Request req) throws ServletException {
            // user has finished editing.
            // validate data
            HashMap errors = new HashMap();
            
            // get the list of user ids
            InputNode inp =
	      singleMode ? (InputNode)inpSingleUser : (InputNode)inpUsers;
            String input = req.getParam(inp);
            String[] names = input.split("[\\r\\n]+");
            List validatedUsers = new ArrayList(names.length);

            recreateInputs(req);
            inp = singleMode?(InputNode)inpSingleUser:(InputNode)inpUsers;
                        
            // validate the list of user ids
            if (singleMode && (names == null || names.length != 1)) {
                errors.put(inp, "Please enter a single user id.");
            }
            else {
                String errMsg = "";
                for (int i = 0; i < names.length; i++) {
                    String userID = names[i];
                    User u = (User)main.cal.users.get(userID); 
                    if (u == null) {
                        errMsg += userID + " is not a valid user id. ";
                    }
                    else {
                        validatedUsers.add(u);
                    }
                }
                if (errMsg.length() > 0) {
                    errors.put(inp, errMsg);
                }
            }
            
            // send user back to page if data not validated
            if (!errors.isEmpty()) {
                return producePage(req, errors);
            }

            // list is valid, so store the users into the user list
            SelectUsersAction.this.userList.clear();
            SelectUsersAction.this.userList.addAll(validatedUsers);

            // send user back to return action.
            return SelectUsersAction.this.successAction.invoke(req);
        }        
    }
    
    private class CancelSelectUsers extends CalendarAction {
        public CancelSelectUsers(Main s) {
            super(s);
        }
        
        public Page invoke(Request req) throws ServletException {
            // user has cancelled the event. Clear out the event information.
            SelectUsersAction.this.userList = null;
            // send user back to return action.
            return SelectUsersAction.this.cancelAction.invoke(req);
        }
        
    }    
    
    private Page producePage(Request req, HashMap errors) {
        String title = "Select User" + (singleMode?"":"s");
	NodeList blurb = new NodeList(new Paragraph(new Text(message)));
	if (!singleMode) {
	    blurb =
	      blurb.append(new Paragraph(new Text("Enter each user id on a "
		      + "separate line.")));	    
	}
	NodeList entries =
	  new NodeList(desc(singleMode ? "Select user" : "Select users"),
	      inpNode(singleMode ? (InputNode)inpSingleUser
		: (InputNode)inpUsers, listToString(this.userList), errors));
	entries =
	      entries.append(new TRow(new TCell(new SubmitButton(getServlet(),
			"OK"))));
        
        entries = entries.append(new TRow(new TCell(new Hyperlink(req,
		  new CancelSelectUsers(main),
		  new Text("Cancel")))));     
        Node content = getServlet().createForm(new FinshSelectUsers(main),
	  req, new Table(null, entries)); 
        
	return getServlet().createPage(title, new NodeList(new Text(title),
	    blurb, content));        
    }
    
    // helper methods for producing the output
    private void recreateInputs(Request req) {
        String defaultUsers = listToString(this.userList);
        if (req != null) {
            if (req.getParam(inpSingleUser) != null) {
                defaultUsers = req.getParam(inpSingleUser); 
            }
            if (req.getParam(inpUsers) != null) {
                defaultUsers = req.getParam(inpUsers); 
            }
        }
        
        this.inpSingleUser = new TextInput(getServlet(), 40, defaultUsers);
        this.inpUsers = new TextArea(getServlet(), 3, 40, defaultUsers);        
    }
    /**
     * Convert a list of Users to a string
     * @param list
     * @return
     */
    private String listToString(List list) {
        StringBuffer sb = new StringBuffer();
        for (Iterator iter = list.iterator(); iter.hasNext(); ) {
            User u = (User)iter.next();
            sb.append(u.getUserID());
            if (iter.hasNext()) {
                sb.append("\n");                
            }
        }
        return sb.toString();
    }

    private Node desc(String txt) {
        Tag n = new TCell(new Text(txt));
        n.setClass("desc");
        return n;
    }
    private Node inpNode(InputNode inp, String text, HashMap errors) {
        TCell cell = new TCell(inp);

        if (errors == null || !errors.containsKey(inp)) {
            return cell;
        }
        // There is an error for this input
        TCell err = new TCell(new Text((String)errors.get(inp)));
        err.setClass("error");
        return new NodeList(cell, err);
    }
}
