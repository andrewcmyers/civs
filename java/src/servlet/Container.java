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
public class Container extends Node {
	String tag;
	Node contents;
	
	Container(String tag_, Node n) {
		tag = tag_;
		contents = n;
	}
	
	public void write(HTMLWriter p) {
		p.print("<" + tag + ">");
		p.begin();
		contents.write(p);
		p.end();
		p.print("</" + tag + ">");
	}
}
