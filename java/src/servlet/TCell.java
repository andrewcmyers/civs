package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TCell extends Container {
    boolean header;
    int colspan;
    public TCell(Node n) {
        super("td", n);
        header = false;
        colspan = 1;
    }
    public TCell(String class_, Node n, int colspan_, boolean header_) {
        super(header_ ? "th" : "td", class_, n);
        colspan = colspan_;
    }
    
    protected void writeOptions(HTMLWriter p) {
        if (colspan != 1) {
            p.print(" colspan=");
            p.print(colspan);
        }
    }
}
