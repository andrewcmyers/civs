package servlet;

/**
 * @author andru
 *
 * A NodeList is a sequence of HTML nodes acting as a single node.
 */
public class NodeList extends Node {
	Node first;
	NodeList rest;
	
	public NodeList(Node n1) {
		first = n1;
		rest = null;
	}	
	public NodeList(Node n1, Node n2) {
		first = n1;
		rest = new NodeList(n2);	
	}
	public NodeList(Node n1, Node n2, Node n3) {
		first = n1;
		rest = new NodeList(n2, n3);	
	}
	public NodeList(Node n, NodeList l) {
		first = n;
		rest = l;
	}
	public void write(HTMLWriter w) {
		NodeList n = this;
		while (n != null) {
			n.first.write(w);
			n = n.rest;
			if (n != null) w.breakLine();
		}
	}
	public NodeList append(Node n2) {
		if (rest != null) {
			return new NodeList(first, rest.append(n2));
		} else {
			return new NodeList(first, new NodeList(n2));
		}
	}
}
