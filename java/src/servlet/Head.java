package servlet;

/**
 * The head of an HTML page.
 */
public class Head extends Node {
	String title;
	String styleFile;
	
	public Head(String t) {
		this(t, null);
	}
	public Head(String t, String sf) {
		title = t;
		styleFile = sf;
	}

	public void write(HTMLWriter w) {
		w.print("<head>");
		w.breakLine();
		w.print("  <title>");
		w.escape(title);
		w.print("</title>");
		w.breakLine();
		if (styleFile != null) {
			w.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"" + styleFile + "\"");
			w.breakLine();
		}
		w.print("</head>");
		w.breakLine();
	}
}
