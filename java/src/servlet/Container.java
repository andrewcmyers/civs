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
	
	protected void writeOptions(HTMLWriter p) {
		// default: no options.
	}
	
	public void write(HTMLWriter p) {
		p.print("<");
		p.print(tag);
		writeOptions(p);
		p.print(">");
		p.begin();
		contents.write(p);
		p.end();
		p.breakLine();
		p.print("</" + tag + ">");
		p.breakLine();
	}
}
