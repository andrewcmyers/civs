package servlet;

/** A Form contains Inputs and generates requests. */
public class Form extends Container {
	Action action;
	String servlet_url;
	Form(Node n, Action action_, Servlet srv) {
		super("form", n);
		action = action_;
		servlet_url = srv.url();
		srv.addAction(action);
	}
	public void writeOptions(HTMLWriter p) {
		p.print(" ");
		p.begin();
		p.print("method=\"GET\"");
		p.breakLine();
		p.print("enctype=\"multipart/form-data\"");
		p.breakLine();
		p.print("action=");
		p.printq(servlet_url);
		p.end();		
	}
	
	void hidden(HTMLWriter p, String name, String value) {
		p.print("<input type=\"hidden\" name=");
		p.printq(name);
		p.print(" value=");
		p.printq(value);
		p.print(" />");
	}
	
	public void writeContents(HTMLWriter p) {
		contents.write(p); p.breakLine();
		hidden(p, "action", action.name.toHex()); p.breakLine();
		p.print("<input type=\"submit\" value=\"Submit\" />");
	}
}
