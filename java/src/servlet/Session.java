package servlet;

/**
 * @author andru
 *
 * A Session is an abstraction for a session of interaction between the client
 * and the servlet, consisting of a series of related requests and responses.
 * Responses from a given session contain the session identifier so that
 * requests made within a session are treated as being part of the given session.
 */

public class Session {
	String name;
	Servlet servlet;

	String name() {
		return name;
	}
	Session(Servlet srv) {
		servlet = srv;
		name = srv.nonce.generate();		
	}

}
