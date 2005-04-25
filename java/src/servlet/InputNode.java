package servlet;

/**
 * @author andru
 *
 * An Input node is one that accepts user input. It
 * must occur within a form. There are several kinds
 * of Input nodes. Every input is associated with a
 * servlet. Input nodes should result in HTML decorations
 * that describe confidentiality requirements. Currently
 * this is not implemented.
 */
public abstract class InputNode extends Node {
	Input input;
	InputNode(Input i) {
		input = i;
	}
	
	public abstract void write(HTMLWriter p);
}
