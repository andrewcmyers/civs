package servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


abstract public class Servlet extends HttpServlet {

  public abstract Page get(Request req) throws ServletException;

  public void doGet(HttpServletRequest request,
  					HttpServletResponse response)
    throws IOException, ServletException {
      response.setContentType("text/html");

      Request req = new Request(request);
      Node n = get(req);
      PrintWriter rw = response.getWriter();
      n.write(new HTMLWriter(rw));

      rw.close();
  }
}
