/*
 * Created on Mar 8, 2005
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
public class Page extends Node {
	Head head;
	Body body;
	
	public Page(Head h, Body b) {
		head = h;
		body = b;
	}

	/* (non-Javadoc)
	 * @see servlet.Node#write(java.io.PrintWriter, int)
	 */
	public void write(HTMLWriter p) {
		head.write(p);
		body.write(p);
	}
}
