
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
		super("table", null);
		head = h;
		body = b;	
	}
	public Table(String class_, Node h, Node b) {
		super("table", class_);
		head = h;
		body = b;
	}
	
	public void write(HTMLWriter p) {
		p.begin();
		p.indent(2);
		super.write(p);
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
