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
	String name() {
		return name;
	}
	Session() {
		name = Nonce.generate();
	}
}
