package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TCell extends Container {
	boolean header;
	public TCell(Node n) {
		super("td", n);
		header = false;
	}
	TCell(Node n, boolean header_) {
		super(header_ ? "th" : "td", n);
	}
}
