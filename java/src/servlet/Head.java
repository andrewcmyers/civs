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
public class Head extends Node {
	String title;
	
	public Head(String t) {
		title = t;
	}

	/* (non-Javadoc)
	 * @see servlet.Node#write(java.io.PrintWriter, int)
	 */
	public void write(HTMLWriter w) {
		w.print("<head>");
		w.breakLine();
		w.print("  <title>");
		w.print(title);
		w.print("</title>");
		w.breakLine();
		w.print("</head>");
	}

}
