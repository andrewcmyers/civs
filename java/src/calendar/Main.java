package calendar;

import java.util.*;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
  Calendar cal;
  String servletHost;
  Map servletParams;

  public Main() {
    cal = new Calendar();
    servletParams = new HashMap();
  }

  public void initialize() {
    addAction(new ShowCalendar(this));

    try {
      servletHost = servletParam("servlet_host", "the Calendar servlet host");
    } catch (ServletException e) {
      servletHost = e.getMessage();
    }
  }

  public String getPrivateHostID() throws ServletException {
    return "";
  }

  public String servletHost() {
    return servletHost;
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

