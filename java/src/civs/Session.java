package civs;

import servlet.Name;
import servlet.Servlet;

/**
 * A Session is an abstraction for a session of interaction between the client
 * and the servlet, consisting of a series of related requests and responses.
 * Session objects contain state that must be maintains across the session.
 * Responses from a given session contain the session identifier so that
 * requests made within a session are treated as being part of the given session.
 * Actual request processing is generally done within Action objects.
 * @author andru
 * @deprecated Actions have largely replaced Sessions.
 */

abstract public class Session {
	Session parent;
	Name name;
	Servlet servlet;
	
	public final Name name() {
		return name;
	}
	
	/** Create a session.
	 * 
	 * @param parent_
	 * This is the session from which this session derived, or null if this
	 * is a start session.
	 * @param srv
	 * The servlet instance associated with the session.
	 */
	public Session(Session parent_, Servlet srv) {
		parent = parent_;
		servlet = srv;
		//name = new Name(srv.nonce.generate());
		//servlet.addSession(this);
	}
	public final boolean equals(Object s) {
		if (s instanceof Session) {
			Session s_ = (Session)s;
			return s_.name() == name;
		}
		return false; 
	}
	public final int hashCode() {
		return name.hashCode();
	}
	public Servlet servlet() { return servlet; }
	
}
