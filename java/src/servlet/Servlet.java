package servlet;
import java.io.*;
import java.util.HashMap;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Map;

/** A servlet contains the information that is shared across users and sessions.
 * It converts between the Java HttpServlet request processing style and this one. */
 
abstract public class Servlet extends HttpServlet {

	Nonce nonce;
	String hostID; // a secret identifier used to construct nonces, sign msgs, etc.
	int concurrent_requests;
	Map actions;
	String style_sheet_url;
	boolean initialized = false;
		
	synchronized void increment_req_cnt() {
		concurrent_requests++;
	}
	synchronized void decrement_req_cnt() {
		concurrent_requests--;
	}
	
	public final int concurrentRequests() {
		return concurrent_requests;
	}
		
	public final void init(ServletConfig sc) throws ServletException {
		super.init(sc);
		nonce = new Nonce(this);
		actions = new HashMap();
		
		initialize();
	}
	
	public abstract void initialize();
	
	public final Page createPage(String title, Node body) {
		String style_sheet = getInitParameter("style_sheet_url");
		return new Page(new Head(title, style_sheet),
						new Body(body));
	}
	
	public final Node createForm(Action action, Node body) {
		return new Form(body, action, this);
	}
		
	public final void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
		increment_req_cnt();
		try {
			response.setContentType("text/html");
			
			Request req = new Request(this, request);
			PrintWriter rw = response.getWriter();
			
			String request_name = req.request_name();
			
			servlet.Action action = null;
			
			if (request_name == null) {				
				String action_name_s = req.action_name();
				if (action_name_s == null) {
					Node n = reportError("Access violation", "Improper request",
					"The request includes no action identifier");
					n.write(new HTMLWriter(rw));
				} else {
					Name action_name = null;
					boolean ok = true;
					try {
					   action_name = new Name(action_name_s);
					} catch (IllegalArgumentException e) {
						Node n = reportError("Access violation", "Invalid action",
						"The action identifier " + action_name_s + " is ill-formed (" + e + ").");
						n.write(new HTMLWriter(rw));
						ok = false;
					}
					// decode hex
					if (ok && actions.containsKey(action_name)) {
						action = (Action) actions.get(action_name);
					} else {
						Node n = reportError("Access violation", "Invalid Action",
								"The action identifier in the request is invalid: \"" + action_name_s + "\"");
						n.write(new HTMLWriter(rw));
					}
				}
			} else {
				if (actions.containsKey(request_name)) {
					action = (Action) actions.get(request_name);
				} else {
					Node n = reportError("Access violation", "Invalid Request",
							"The request operation is invalid: \"" + request_name + "\"");
					n.write(new HTMLWriter(rw));
				}
			}				
	
			if (action != null) {
				Node n = action.invoke(req);
				
				if (n != null) {
					n.write(new HTMLWriter(rw));
				} else {
					n = reportError("Error handling request",
							"Error Handling Request",
							"The servlet did not generate any output for your request. " +
					"This probably means that your request was ill-formed.");
					n.write(new HTMLWriter(rw));			
				}
			}
			
			rw.close();
		}
		finally { decrement_req_cnt(); }
	}
	
	protected Node reportError(String title, String header, String explanation) {
		return createPage(title, new NodeList(new Header(1, header),
				new Paragraph(new Text(explanation))));
	}
	
	public final String initParameter(String p) {
		return getServletConfig().getInitParameter(p);
	}
	
	public final String url() {
		return initParameter("servlet_url");
	}
	
	/** These servlets currently do not distinguish between GET and POST requests. */
	public final void doPost(HttpServletRequest req, HttpServletResponse res)
	throws IOException, ServletException {
		doGet(req, res);	
	}
	
	public abstract String getPrivateHostID() throws ServletException;
	
	final void addAction(Action a) {
		Name n = a.name;
		actions.put(n, a);
	}
	
	/** Set up this action as a way to create a new session.  Means that
	 * these actions can be invoked from "outside" the system, as a URL.
	 */
	public final void addStartAction(String action_name, Action action) {
		actions.put(action_name, action);
	}
}
