/*
 * Created on Mar 14, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Pre extends Container {
	public Pre(Node n) {
		super("pre", n);
	}
	public void write(HTMLWriter p) {
		p.print("<" + tag + ">");
		p.noindent(true);
		contents.write(p);
		p.noindent(false);
		p.breakLine();
		p.print("</" + tag + ">");
		p.breakLine();
	}
}
