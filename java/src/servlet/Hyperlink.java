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
	public void writeOptions(HTMLWriter p) {
		p.print(" href=");
		p.print("\"");
		p.print(HTMLWriter.escape_URI(url));
		p.print("\"");
	}
}
