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
		this(tag_, n, null);
	}
	
	Container(String tag_, Node n, String class_) {
		super(class_);
		tag = tag_;
		contents = n;
	}
	
	protected void writeOptions(HTMLWriter p) {
		// default: no options.
	}
	
	protected void writeContents(HTMLWriter p) {
		contents.write(p);
	}
	public void write(HTMLWriter p) {
		p.begin();
		p.indent(2);
		p.print("<");
		p.print(tag);
		if (class_ != null) {
			p.print("class=");
			p.printq(class_);
		}
		writeOptions(p);
		p.print(">");
		p.breakLine();
		writeContents(p);
		p.end();
		p.breakLine();
		p.print("</" + tag + ">");
		p.breakLine();
	}
}
