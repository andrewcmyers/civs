package servlet;

/**
 * @author andru
 *
 * An Input node is one that accepts user input. It
 * must occur within a form. There are several kinds
 * of Input nodes. Every input is associated with a
 * servlet.
 */
public abstract class Input extends Node {
	Name name;
	Input(Servlet s) {
		name = s.nonce.generate();
	}
	/** For use by radiobuttons, etc. */
	Input(Name n) {
		name = n;
	}
	public abstract void write(HTMLWriter p);
	
	/** The name of the input. */
	String getName() {
		return "i" + name.toHex();
	}
}
