package servlet;

/**
 * The head of an HTML page.
 */
public class Head extends Node {
	String title;
	
	public Head(String t) {
		title = t;
	}

	public void write(HTMLWriter w) {
		w.print("<head>");
		w.breakLine();
		w.print("  <title>");
		w.escape(title);
		w.print("</title>");
		w.breakLine();
		w.print("</head>");
		w.breakLine();
	}
}
