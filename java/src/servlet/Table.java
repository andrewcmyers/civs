
package servlet;

/** An HTML table. */
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
            p.breakLine();
            head.write(p);
            p.print("</thead>");
            p.breakLine();
        }
        p.print("<tbody>");
        p.breakLine();
        body.write(p);
        p.indent(-2);
        p.print("</tbody>");
        p.print("</table>");
        p.end();
    }
}
