package servlet;

/**
 * @author andru
 *
 * An Input node is one that accepts user input. It
 * must occur within a form. There are several kinds
 * of Input nodes. Every input has a name which is used
 * to bind the actual input sent when the form is
 * submitted.
 */
public abstract class Input extends Node {
	String name;
	Input(String name_) {
		name = name_;
	}
	public abstract void write(HTMLWriter p);
	
	/** The name of the input. */
	String getName() {
		return name;
	}
}
