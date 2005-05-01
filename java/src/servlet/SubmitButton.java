package servlet;

/**
 * @author andru
 *
 * A button that submits a form.
 */
public class SubmitButton extends InputNode {
    String name;
    
    public SubmitButton(Servlet s, String name_) {
        super(new Input(s));
        name = name_;
    }
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.print("<input type=submit class=submit value=");
        p.printq(name);
        p.print(" name=");
        p.printq(input.getName());
        p.print(" />");
    }
    
}
