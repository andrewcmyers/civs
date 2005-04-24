
package servlet;

public class CheckBox extends InputNode {
	boolean checked;
	Servlet servlet;
	/**
	 * @param s  The servlet.
	 * @param checked_   Whether the checkbox should initially be checked.
	 * @return 	  A new checkbox.
	 */
	public CheckBox(Servlet s, boolean checked_) {
		super(new Input(s));
		servlet = s;
		checked = checked_;
	}

	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		p.print("<input type=checkbox");
		p.print(" name=");
		p.printq(input.getName());
		p.print(" value=yes");
		if (checked) p.print(" checked");
		p.print(" />");
	}
	
	/** 
	 * @param r
	 * @return whether this checkbox is checked.
	 */
	public boolean isChecked(Request r) {
		if (r.getParam(input) == null) return false;
		return r.getParam(input).equals("yes");
	}
}
