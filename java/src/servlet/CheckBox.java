
package servlet;

public class CheckBox extends Input {
	boolean checked;
	/**
	 * @param s
	 */
	public CheckBox(Servlet s, boolean checked_) {
		super(s);
		checked = checked_;
	}

	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		p.print("<input type=checkbox");
		p.print(" name=");
		p.printq(getName());
		p.print(" value=");
		if (checked) p.print("yes");
		else p.print("no");
		p.print(" />");
	}

}
