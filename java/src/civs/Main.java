package civs;

import servlet.*;
import javax.servlet.ServletException;

public final class Main extends Servlet {	
	public Page get(Request request) throws ServletException {
		if (request.startsSession()) {
		
		}
		return new Page(new Head("CIVS Test page"),
			            new Body(
			            	new NodeList(
			            		new Header(1, "A Test Servlet"),
			            		new Paragraph(new Text("This is some text.\n" +
			            								"It is very nice text.")))));
	}
}
