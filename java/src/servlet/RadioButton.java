package servlet;

/**
 * A Radio Button input. Any of the radio buttons may be queried to find
 * out the value of the buttion that was selected.
 * 
 * @author andru
 *
 */
public class RadioButton extends Input {
	boolean checked;
	public RadioButton(Radio r, String value, boolean checked_) {
		super(r.name);		
		checked = checked_;
	}
	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		p.print("<input type=radio");
		p.print(" name=");
		p.printq(getName());
		if (checked) p.print(" checked");
		p.print(" />");
	}
}
