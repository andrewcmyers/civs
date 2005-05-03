
package servlet;

/** An HTML table. */
public class Table extends Tag {
    Node head, body;
    int cell_spacing; // no way to do this in a style file!
    boolean have_cell_spacing = false;
    
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
    
    public Table setCellSpacing(int s) {
        cell_spacing = s;
        have_cell_spacing = true;
        return this;
    }
    
    public void writeOptions(HTMLWriter p) {
        super.writeOptions(p);
        if (have_cell_spacing) {
            p.print(" cellspacing=");
            p.printq(cell_spacing);
        }
    }
    
    public void write(HTMLWriter p) {
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
        p.end();
        p.breakLine();
        p.print("</tbody>");
        p.print("</table>");
        p.breakLine();
    }
}
