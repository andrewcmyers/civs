package civs;

import servlet.*;

public final class Main extends Servlet {
  public Node get(Request request) throws ServletException {
     return new PageNode(
	new HeadNode("Test page"),
	new BodyNode(new Paragraph(
	    new Text("This is some text."))));
  }
}
