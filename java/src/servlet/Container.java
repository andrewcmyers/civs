package servlet;

/**
 * @author andru
 *
 * A container is an HTML form that starts with a
 * begin tag and ends with an end tag. This class has
 * package scope to prevent arbitrary use.
 */
class Container extends Node {
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
		p.breakLine();
		p.print("</" + tag + ">");
		p.breakLine();
	}
}
