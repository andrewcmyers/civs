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
 * A horizontal rule (<hr>)
 */
public class HRule extends Node {

	public void write(HTMLWriter p) {
		p.print("<hr/>");
		p.breakLine();
	}
}
