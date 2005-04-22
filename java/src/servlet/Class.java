package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Class extends Node {
	String class_;
	Node node;
	
	Class(String c, Node n) {
		class_ = c;
	}
	/* (non-Javadoc)
	 * @see servlet.Node#write(servlet.HTMLWriter)
	 */
	public void write(HTMLWriter p) {
		// TODO Auto-generated method stub
		p.setClass(class_);
		node.write(p);
		p.setClass(null);		
	}

}
