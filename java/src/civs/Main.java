package civs;

import servlet.*;
import javax.servlet.ServletException;

public final class Main extends Servlet {
	public Page get(Request request) throws ServletException {
		return new Page(new Head("Test page"),
			            new Body(new Paragraph(new Text("This is some text."))));
	}
}
