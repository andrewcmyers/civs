
package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Table extends Tag {
	Node head, body;
	
	public Table(Node h, Node b) {
		super("table");
		head = h;
		body = b;
	}
	
	public void write(HTMLWriter p) {
		p.begin();
		p.indent(2);
		p.print("<table>");
		if (head != null) {
			p.print("<thead>");		
			head.write(p);
			p.end();
			p.print("</thead>");
			p.breakLine();
		}
		p.print("<tbody>");
		body.write(p);
		p.print("</tbody>");
		p.breakLine();
		p.end();
		p.print("</table>");
		p.breakLine();
	}
}
