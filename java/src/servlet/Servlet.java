package servlet;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class Servlet extends HttpServlet {

  abstract PageNode get(Request req) throws ServletException;

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
      response.setContentType("text/html");
      Request req = new Request(request);
      Response res = new Response(response);
      Node n = get(req, res);
      n.write(response.getWriter());
  }
}
