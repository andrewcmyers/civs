package servlet;

/**
 * @author andru
 *
 * A horizontal rule: <hr>
 */
public class HRule extends Node {

	public void write(HTMLWriter p) {
		p.print("<hr/>");
		p.breakLine();
	}
}
