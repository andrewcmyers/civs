package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Header extends Node {
	int level;
	String text;
	
	public Header(int level, String text) {
		this.level = level;
		this.text = text;
	}
 
	public void write(HTMLWriter p) {
		p.print("<h");
		p.print(level);
		p.print(">");
		p.begin();
		p.escape(text);
		p.end();
		p.print("</h");
		p.print(level);
		p.print(">");
	}
}
