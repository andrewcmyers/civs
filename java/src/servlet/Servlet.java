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
	
	public int concurrentRequests() {
		return concurrent_requests;
	}
		
	public final void init(ServletConfig sc) throws ServletException {
		System.out.println("Initializing servlet with " + sc);
		super.init(sc);
		nonce = new Nonce(this);
		start_actions = new HashSet();
		
		initialize();
	}
	
	public abstract void initialize();
	
	public Head createHead(String title) {
		String style_sheet = getInitParameter("style_sheet");
		return new Head(title, style_sheet);
	}
	
	public abstract Page get(Request req) throws ServletException;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
		increment_req_cnt();
		response.setContentType("text/html");
		
		Request req = new Request(this, request);
		PrintWriter rw = response.getWriter();
		
		servlet.Session session = req.session();
		String action = req.action();
		if (session == null) {
			if (start_actions.contains(action)) {
				session = new Session(this);
			} else {
				Node n = reportAccessViolation("Request (" + action + ") has no session identifier.");
				n.write(new HTMLWriter(rw));
				decrement_req_cnt();
				rw.close();
				return;
			}
		}
		Node n = get(req);
		n.write(new HTMLWriter(rw));
		
		decrement_req_cnt();
		
		rw.close();
	}
	
	protected Node reportAccessViolation(String s) {
		return new Page(createHead("Access violation"), new Body(new NodeList(new Header(1, "Access Violation"), new Text(s))));
	}
	
	public String initParameter(String p) {
		System.out.println("getting " + p);
		System.out.println("Server config is " + getServletConfig());
		return getServletConfig().getInitParameter(p);
	}
	
	/** These servlets currently do not distinguish between GET and POST requests. */
	public void doPost(HttpServletRequest req, HttpServletResponse res)
	throws IOException, ServletException {
		doGet(req, res);	
	}
	
	public abstract String getPrivateHostID() throws ServletException;
	
	public Session findSession(String name) throws SessionNotFound {
		Object o = sessions.get(name);
		if (o == null) throw new SessionNotFound();
		return (Session)o;
	}
	
	/** Set up this action as a way to create a new session. */
	public final void addSessionStart(String action) {
		start_actions.add(action);
	}
}
