package servlet;

/**
 * @author andru
 *
 * A <select> input appliance.
 */
public class Select extends InputNode {
    Option[] options;
    int selected;
    public Select(Servlet s, int selected_, Option[] options_) {
        super(new Input(s));
        options = options_;
        selected = selected_;    
    }

    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        // TODO Auto-generated method stub
        p.begin(2);
        p.print("<select name=");
        p.printq(input.getName());
        p.print(">");
        for (int i = 0; i < options.length; i++) {
            p.breakLine();
            if (i == selected)
                p.print("<option selected>");
            else
                p.print("<option>");
            p.escape(options[i].name);
            p.print("</option>");
        }
        p.end();
        p.breakLine();
        p.print("</select>");
    }

}
