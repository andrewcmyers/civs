package servlet;
import java.io.*;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Map;

/** A servlet contains the information that is shared across users and sessions.
 * It converts between the Java HttpServlet request processing style and this one. */
 
abstract public class Servlet extends HttpServlet {

	Nonce nonce;
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
	
	public final Node createForm(Action action, Node body, Request req) {
		return new Form(body, action, req);
	}
	
	/** checkLoad implements load checking for the servlet,
	 * probably by comparing concurrentRequests() against some
	 * specified maximum.
	 * @return null if load is acceptable, or else the page to be returned as an
	 * error message.
	 */
	protected Node checkLoad() {
		return null;
	}
		
	public final void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
		increment_req_cnt();
		
		try {
			response.setContentType("text/html");
			if (request.getCharacterEncoding() == null)
				request.setCharacterEncoding("ISO-8859-1");						
			
			Request req = new Request(this, request);
			PrintWriter rw = response.getWriter();
			
			Node loadMsg = checkLoad();
			if (loadMsg != null) {
				loadMsg.write(new HTMLWriter(rw));
				rw.close();
				return;
			}
			
			servlet.Action action = null;
			if (false) { // debugging: dump parameter names
				HTMLWriter p = new HTMLWriter(rw);
				String params = "";
				for (Enumeration i = request.getParameterNames(); i.hasMoreElements();) {
					String name = (String)i.nextElement();
					params += name;
					params += "=";
					params += request.getParameter(name);
					params += "\n";
				}
						
				createPage("params", new Pre(new Text(params))).write(p);
			}
			if (false) { // debugging: dump form data
				HTMLWriter p = new HTMLWriter(rw);
				String s = "";
				BufferedReader in = request.getReader();
				while (true) {
					String ln = in.readLine();
					if (ln == null) break;
					s += ln;
					s += '\n';
				}
				createPage("request", new Pre(new Text(s))).write(p);
			}	
			
			String action_name = req.action_name();
			if (action_name == null) {
				Node n = reportError("Access violation", "Improper request",
						"The request includes no action identifier \"" + req.title() + "\"");
				n.write(new HTMLWriter(rw));
				rw.close();
				return;
			}
			
			if (actions.containsKey(action_name)) {
				action = (Action) actions.get(action_name);
			} else {
				Node n = reportError("Access violation", "Invalid Action",
					"The action identifier in the request is invalid: <" + action_name + ">");
				n.write(new HTMLWriter(rw));
				rw.close();
				return;			
			}
	
			Node n = action.invoke(req);				
			if (n != null) {
				n.write(new HTMLWriter(rw));
			} else {
				n = reportError("Error handling request", "Error Handling Request",
							"The servlet did not generate any output for your request. " +
							"This probably means that your request was ill-formed.");
				n.write(new HTMLWriter(rw));
			}

			rw.close();
		}
		finally { decrement_req_cnt(); }
	}
	
	protected Page reportError(String title, String header, String explanation) 
			throws ServletException {
		return createPage(title, new NodeList(new Header(1, header),
				new Paragraph(new Text(explanation))));
	}
	
	public final String initParameter(String p) {
		return getServletConfig().getInitParameter(p);
	}
	
	/** These servlets currently do not distinguish between GET and POST requests. */
	public final void doPost(HttpServletRequest req, HttpServletResponse res)
	throws IOException, ServletException {
		doGet(req, res);	
	}
	
	public abstract String getPrivateHostID() throws ServletException;
	
	final void addAction(Action a) {
		Name n = a.name;
		actions.put(n.toHex(), a);
	}
	
	public String generateNonce() {
		return nonce.generate().toHex();
	}
	
	/** Set up this action as a way to create a new session.  Means that
	 * these actions can be invoked from "outside" the system, as a URL in a static
	 * web page or email message.
	 * @param action_name A name that can be used externally to invoke this action.
	 */
	 // XXX should also be sent a set of Inputs?
	public final void addStartAction(String action_name, Action action) {
		actions.put(action_name, action); // XXX do we need args?
	}
	/** Construct a node that contains an invocation of this servlet with the
	 * named request and the inputs provided.
	 * @param action_name the name of the action (or the action itself?)
	 * @param inputs : Input -> String
	 * @param req : the request that initiated this
	 * @return a new node.
	 */
	public final Node createRequest(Action a, Map inputs, Node body,
			Request req) throws ServletException {

		// XXX check inputs against the request?
		StringWriter w = new StringWriter();
		w.write(req.servlet_url());
		w.write("?action=");
		w.write(HTMLWriter.escape_URI(a.getName()));
		
		if (inputs != null)
		  for (Iterator i = inputs.entrySet().iterator(); i.hasNext();) {
			Map.Entry entry = (Map.Entry)i.next();
			Input inp = (Input) entry.getKey();
			String val = (String) entry.getValue();
			w.write("&");
			w.write(inp.name);
			w.write("=");
			w.write(HTMLWriter.escape_URI(val));
		  }
		return new Hyperlink(w.toString(), body);
	}
	/** The set of input names used so far. Each input must have
	 * a unique name, ensuring that the program doesn't receive
	 * data on one input that was intended for another input with
	 * a different label. */
	Set inputNames = new HashSet();
	
	boolean hasInputName(String n) {
		return inputNames.contains(n);
	}
	void addInputName(String n) {
		if (inputNames.contains(n))
			throw new IllegalArgumentException("Duplicate input name: " + n);
		inputNames.add(n);
	}
}
