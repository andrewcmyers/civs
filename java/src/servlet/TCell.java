package servlet;

/**
 * A table cell.
 */
public class TCell extends BlockContainer {
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
            p.unifiedBreak();
            p.print("colspan=");
            p.print(colspan);
        }
    }
}
