package servlet;

import javax.servlet.ServletException;

/**
 * @author andru
 *
 * An Action represents some servlet behavior to be triggered
 * by a user request. An action expects to receive some
 * parameters from the request.
 * 
 * Real servlets create subclasses of action to provide
 * request handling.
 */
abstract public class Action {
	public final Name name;
	public Action(Servlet s) {
		name = s.nonce.generate();
	}
	abstract public Page invoke(Request req) throws ServletException;
}
