package servlet;

/** A Form contains Inputs and generates requests. */
public class Form extends Container {
    Action action;
    String servlet_url;
    Form(Action action_, Request req, Node n) {
        super("form", n);
        action = action_;
        servlet_url = req.servletURL();
        req.servlet.addAction(action, req);
    }
    public void writeOptions(HTMLWriter p) {
        p.print(" ");
        p.begin();
        p.print("method=POST");
        p.breakLine();
        //p.print("enctype=\"multipart/form-data\"");
        //p.breakLine();
        p.print("action=");
        p.print("\"");
        p.print(HTMLWriter.escape_URI(servlet_url));
        p.print("\"");
        p.breakLine();
        p.print("name=");
        p.printq(action.name.toHex());
        p.end();
    }
    
    void hidden(HTMLWriter p, String name, String value) {
        p.print("<input type=\"hidden\" name=");
        p.printq(name);
        p.print(" value=");
        p.printq(value);
        p.print(" />");
    }
    
    public void writeContents(HTMLWriter p) {
        p.breakLine();
        contents.write(p);
        p.breakLine();
        hidden(p, "action", action.name.toHex());
    }
}
