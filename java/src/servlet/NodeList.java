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
public class NodeList extends Node {

	Node first;
	NodeList next;
	public NodeList(Node n1) {
		next = null;
		first = n1;
	}
	
	public NodeList(Node n1, Node n2) {
		first = n1;
		next = new NodeList(n2);		
	}
	public NodeList(Node n1, Node n2, Node n3) {
		first = n1;
		next = new NodeList(n2, n3);	
	}
	public NodeList(Node n, NodeList l) {
		first = n;
		next = l;
	}
	public void write(HTMLWriter w) {
		NodeList n = this;
		while (n != null) {
			first.write(w);
			n.write(w);
			n = n.next;
		}
	}
}
