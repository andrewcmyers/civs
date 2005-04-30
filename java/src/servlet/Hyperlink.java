package servlet;

/**
 * @author andru
 *
 * A Hyperlink -- an "a href=" tag.
 */
public class Hyperlink extends Container {
	String url;
	public Hyperlink(String url_, Node n) {
		super("a", n);
		url = url_;
	}
	public Hyperlink(Request req, Action a, Node n) {
		// XXX Steve: is this enough?
		super("a", n);
		url = req.servlet_url() + "?" + a.getName();	
	}
	public void writeOptions(HTMLWriter p) {
		p.print(" href=");
		p.print("\"");
		p.print(HTMLWriter.escape_URI(url));
		p.print("\"");
	}
}
