package servlet;

/**
 * @author andru
 *
 * A TextArea is a multi-line text input with a fixed
 * number of rows and columns.
 */
public class TextArea extends Input {
	int rows;
	int cols;
	String initial_text;

    public TextArea(String name, int rows, int cols, String initial) {
    	super(name);
    	this.rows = rows;
    	this.cols = cols;
    	initial_text = initial;
    }
	public void write(HTMLWriter p) {
		p.print("<textarea");
		p.print(" name=");
		p.printq(getName());
		p.print(" rows=");
		p.printq(rows);
		p.print(" cols=");
		p.printq(cols);
		p.escape(initial_text);
		// what goes here in a textarea?
		p.print("</textarea>");
	}
}
