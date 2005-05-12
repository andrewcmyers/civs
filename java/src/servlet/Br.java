package servlet;

/**
 * @author andru
 *
 * A <br> line-break element.
 */
public class Br extends Node {
    
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.allowBreak();
        p.print("<br/>");
        p.allowBreak(0, 0, "");
    }
}
