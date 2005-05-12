package calendar;

import java.util.*;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
  Calendar cal;
  Map servletParams;
  LogoffAction logoffAction;
  ShowCalendar showCalAction;

  public Main() {
    cal = new Calendar();
    servletParams = new HashMap();
  }

  public void initialize() {
      showCalAction = new ShowCalendar(this);
      logoffAction = new LogoffAction(this);
      addStartAction(showCalAction);
      addStartAction(logoffAction);
  }

  public SessionState createSessionState() {
    return new CalendarSessionState();
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

