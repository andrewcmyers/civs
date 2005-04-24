package servlet;

/**
 * @author andru
 *
 */
public class Input {
	Name name;
	// XXX Should take a label argument too.
	public Input(Servlet s) {
		name = s.nonce.generate();
	}
	
	/** The name of the input. */
	String getName() {
		return "i" + name.toHex();
	}
}
