package servlet;

/**
 * @author andru
 *
 * A Page is an entire HTML page.
 */
public class Page extends Node {
	Head head;
	Body body;
	
	public Page(Head h, Body b) {
		head = h;
		body = b;
	}

	public void write(HTMLWriter p) {
		p.print("<html>");
		p.breakLine();
		head.write(p);
		body.write(p);
		p.print("</html>");
		p.breakLine();
	}
}
