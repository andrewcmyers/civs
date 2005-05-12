package servlet;

/**
 * @author andru
 *
 * A Hidden is a way to pass data directly to an input
 * without the client having to provide it. */
public class Hidden extends InputNode {
    String data;
    public Hidden(Input i, String data_) {
        super(i);
        data = data_;
    }
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.print("<input type=hidden ");
        p.print("name=\"");
        p.print(input.getName());
        p.print("\"");
        p.allowBreak(0,2," ");
        p.print("/>");
    }
}
