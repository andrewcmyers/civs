package calendar;

import java.util.*;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
  Calendar cal;
  Map servletParams;

  // XXX - A dummy user until we figure out how we're representing users.
  public static final User USER;
  static {
    USER = new User();
    USER.id = "guest";
    USER.name = "Guest";
    USER.password = "";
  }

  public Main() {
    cal = new Calendar();
    servletParams = new HashMap();
  }

  public void initialize() {
    addStartAction(new ShowCalendar(this));
  }
  

    protected String defaultActionName(Request req) {
        return "show";
    }
  public String getPrivateHostID() throws ServletException {
    return "";
  }


  String servletParam(String name, String what) throws ServletException {
    if (servletParams.containsKey(name)) {
      return (String)servletParams.get(name);
    }

    String s = initParameter(name);
    if (s == null) {
      throw new ServletException("Can't determine " + what + ".  Set the "
	  + name + " parameter in the configuration file web.xml.");
    } else {
      servletParams.put(name, s);
      return s;
    }
  }
}

