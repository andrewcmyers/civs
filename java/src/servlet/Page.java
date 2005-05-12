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
        p.begin(2);
        p.print("<html>"); 
        p.allowBreak(0, 1, "");
        head.write(p);
        body.write(p);
        p.end();
        p.allowBreak(0, 1, "");
        p.print("</html>");		
        p.allowBreak(0, 1, "");
    }
}
