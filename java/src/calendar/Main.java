package calendar;

import servlet.*;
import javax.servlet.ServletException;

public final class Main extends Servlet {
  Calendar cal = new Calendar();

  public void initialize() {
    addStartAction("show", new ShowCalendar(this));
  }

  public String getPrivateHostID() throws ServletException {
    return "";
  }

  class ShowCalendar extends Action {
    public ShowCalendar(Servlet s) { super(s); }

    public Page invoke(Request req) throws ServletException {
      return createPage("My Calendar", cal.monthToNode(null, null, new java.util.Date()));
    }
  }
}

