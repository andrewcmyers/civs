package servlet;

/** A Form contains Inputs and generates requests. */
public class Form extends Container {
	String action;
	String servlet_url;
	String session_name;
	Form(Node n, String action_, Session session) {
		super("form", n);
		action = action_;
		session_name = session.name();
		servlet_url = session.servlet().url();
	}
	public void writeOptions(HTMLWriter p) {
		p.print(" ");
		p.begin();
		p.print("method=\"GET\"");
		p.breakLine();
		p.print("enctype=\"multipart/form-data\"");
		p.breakLine();
		p.print("action=");
		p.printq(servlet_url + "/" + action);
		p.end();		
	}
	public void writeContents(HTMLWriter p) {
		contents.write(p);
		p.breakLine();
		p.print("<input type=\"hidden\" name=\"session\" value=");
		p.printq(session_name);
		p.print("/>");
		p.breakLine();
		p.print("<input type=\"submit\" value=\"Submit\">");
	}
}
