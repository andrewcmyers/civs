package servlet;

/**
 * Preformatted text, like <pre>example</example>
 *
 * @author andru
 *
**/
public class Pre extends Container {
	public Pre(Node n) {
		super("pre", n);
	}
	public void write(HTMLWriter p) {
		p.print("<" + tag + ">");
		p.noindent(true);
		contents.write(p);
		p.noindent(false);
		p.breakLine();
		p.print("</" + tag + ">");
		p.breakLine();
	}
}
