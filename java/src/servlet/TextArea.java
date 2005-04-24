package servlet;

/**
 * @author andru
 *
 * A TextArea is a multi-line text input with a fixed
 * number of rows and columns.
 */
public class TextArea extends InputNode {
	int rows;
	int cols;
	String initial_text;

    public TextArea(Servlet s, int rows, int cols, String initial) {
    	super(new Input(s));
    	this.rows = rows;
    	this.cols = cols;
    	initial_text = initial;
    }
	public void write(HTMLWriter p) {
		p.print("<textarea");
		p.print(" name=");
		p.printq(input.getName());
		p.print(" rows=");
		p.printq(rows);
		p.print(" cols=");
		p.printq(cols);
		p.escape(initial_text);
		// what goes here in a textarea?
		p.print("</textarea>");
	}
}
