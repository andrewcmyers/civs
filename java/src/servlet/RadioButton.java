package servlet;

/**
 * A Radio Button input. Any of the radio buttons may be queried to find
 * out the value of the button that was selected.
 * 
 * @author andru
 *
 */
public class RadioButton extends InputNode {
    boolean checked;
    public RadioButton(Input i, String value, boolean checked_) {
        super(i);		
        checked = checked_;
    }
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.print("<input type=radio");
        p.print(" name=");
        p.printq(input.getName());
        if (checked) p.print(" checked");
        p.print(" />");
    }
}
