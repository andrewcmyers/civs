package servlet;
import java.io.*;
import java.util.HashMap;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Set;
import java.util.HashSet;

abstract public class Servlet extends HttpServlet {

	Nonce nonce;
	String hostID; // a secret identifier used to construct nonces, sign msgs, etc.
	int concurrent_requests;
	HashMap sessions; // map from session ids to Sessions
	Set start_actions;
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
		start_actions = new HashSet();
		
		initialize();
	}
	
	public abstract void initialize();
	
	public final Page createPage(String title, Node body) {
		String style_sheet = getInitParameter("style_sheet_url");
		return new Page(new Head(title, style_sheet),
						new Body(body));
	}
	
	public final Node createForm(String action, Node body, Session session) {
		return new Form(body, action, session);
	}
	public abstract Page get(Session session, Request req)
	  throws ServletException;
	
	public final void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
		boolean ok = true;
		increment_req_cnt();
		try {
			response.setContentType("text/html");
			
			Request req = new Request(this, request);
			PrintWriter rw = response.getWriter();
			
			servlet.Session session = req.session();
			String action = req.action();
			if (session == null) {
				if (start_actions.contains(action)) {
					session = new Session(this);
				} else {
					Node n = reportError("Access violation", "No Session",
							"Request (" + action + ") has no session identifier.");
					n.write(new HTMLWriter(rw));
					ok = false;
				}
			}
			if (ok) {
				Node n = get(session, req);
				
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
	
	public final Session findSession(String name) throws SessionNotFound {
		Object o = sessions.get(name);
		if (o == null) throw new SessionNotFound();
		return (Session)o;
	}
	
	/** Set up this action as a way to create a new session.  Means that
	 * these actions can be invoked from "outside" the system, as a URL.
	 */
	public final void addSessionStart(String action) {
		start_actions.add(action);
	}
}
