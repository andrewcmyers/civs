package servlet;

/**
 * A Tag represents an HTML node that has a tag.
 * It may or may not have a corresponding end tag.
 **/
public class Tag extends Node {	
	String tag;
	
	Tag(String tagname) {
		tag = tagname;
	}

	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		p.begin();
		p.indent(2);
		p.print("<");
		p.print(tag);
		if (p.currentClass() != null) {
			p.print("class=");
			p.printq(p.currentClass());
			p.setClass(null);
		}
		writeOptions(p);
		p.print(">");
	}
	
	protected void writeOptions(HTMLWriter p) {}
}
