package servlet;

/** A Form contains Inputs and generates requests. */
public class Form extends BlockContainer {
    Action action;
    String servlet_url;
    Form(Action action_, Request req, Node n) {
        super("form", n);
        action = action_;
        servlet_url = req.servletURL();
        req.servlet.addAction(action, req);
    }
    public void writeOptions(HTMLWriter p) {
        p.allowBreak(0, 2, " ");
        p.begin();
        p.print("method=POST");
        p.unifiedBreak();
        //p.print("enctype=\"multipart/form-data\"");
        //p.breakLine();
        p.print("action=");
        p.print("\"");
        p.print(HTMLWriter.escape_URI(servlet_url));
        p.print("\"");
        p.unifiedBreak();
        p.print("name=");
        p.printq(action.name.toHex());
        p.end();
    }
    
    void hidden(HTMLWriter p, String name, String value) {
        p.begin(2);
        p.print("<input");
        p.allowBreak(0, 2, " ");
        p.print("type=\"hidden\"");
        p.unifiedBreak();
        p.print("name=");
        p.printq(name);
        p.unifiedBreak();
        p.print("value=");
        p.printq(value);
        p.end();
        p.allowBreak(0, 2, " ");
        p.print("/>");
    }
    
    public void writeContents(HTMLWriter p) {
        p.breakLine();
        contents.write(p);
        p.breakLine();
        hidden(p, "action", action.name.toHex());
    }
}
