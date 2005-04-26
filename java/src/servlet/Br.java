/*
 * Created on Mar 25, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package servlet;

/**
 * @author andru
 *
 * A <br> line-break element.
 */
public class Br extends Node {

	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		p.print("<br />");
	}
}
