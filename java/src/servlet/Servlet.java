package servlet;
import java.io.*;
import java.util.HashMap;

import javax.servlet.*;
import javax.servlet.http.*;


abstract public class Servlet extends HttpServlet {

	Nonce nonce;
	String hostID; // a secret identifier used to construct nonces, sign msgs, etc.
	int concurrent_requests;
	HashMap sessions; // map from session ids to Sessions
	
	synchronized void increment_req_cnt() {
		concurrent_requests++;
	}
	synchronized void decrement_req_cnt() {
		concurrent_requests--;
	}
	
	public int concurrentRequests() {
		return concurrent_requests;
	}

		
	public void init(ServletConfig sc) throws ServletException {
		System.out.println("Initializing servlet with " + sc);
		super.init(sc);
		nonce = new Nonce(this);		
	}
	
	public abstract Page get(Request req) throws ServletException;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
		increment_req_cnt();
		response.setContentType("text/html");
		
		Request req = new Request(this, request);
		Node n = get(req);
		PrintWriter rw = response.getWriter();
		n.write(new HTMLWriter(rw));
		
		decrement_req_cnt();
		
		rw.close();
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
}
