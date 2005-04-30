package servlet;

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
 */
abstract public class Action {
	public final Name name;
	public final Servlet servlet;
	public Action(Servlet s) {
		name = s.nonce.generate();
		servlet = s;
	}
	abstract public Page invoke(Request req) throws ServletException;

	public String getName() {
		return name.toHex();
	}
	
	public Servlet getServlet() {
		return servlet;
	}
}
