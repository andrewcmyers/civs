package servlet;

/**
 * A Page is an entire HTML page.
 * @author andru
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
        p.indent(2);
        p.breakLine();
        head.write(p);
        body.write(p);
        p.indent(-2);
        p.breakLine();
        p.print("</html>");		
        p.breakLine();
    }
}
