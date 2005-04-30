package calendar;

import java.util.*;

import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
  Calendar cal = new Calendar();

  public void initialize() {
      ShowCalendar sc = new ShowCalendar(this);
      addStartAction("show", sc);
  }

  public String getPrivateHostID() throws ServletException {
    return "";
  }

  class ShowCalendar extends Action {
    public ShowCalendar(Servlet s) { super(s); }

    public Page invoke(Request req) throws ServletException {
        Node content = cal.monthToNode(null, null, new java.util.Date());
        content = new NodeList(content, new Paragraph(new Hyperlink(req, new DoCreateEvent(getServlet(), this), new Text("Create new event"))));

      return createPage("My Calendar", content);
    }
  }

  /**
   * Returns a new Event, filled out with default values.
   */
  private Event defaultEvent() {
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(c.HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(null);
      Set readers = attendees;
      Set timeReaders = Collections.EMPTY_SET;
      return new Event(start, end, "", "", attendees, null, timeReaders, readers);
  }      
  
  class DoCreateEvent extends Action {
    private Action returnAction;
    public DoCreateEvent(Servlet s, Action returnAction) {
        super(s);
        this.returnAction = returnAction;
    }

    public Page invoke(Request req) throws ServletException {
        Event newEvent = defaultEvent(); 
        CreateEditEvent createAction = new CreateEditEvent((Main)getServlet(), 
                                                           new ReceiveCreatedEvent(getServlet(), returnAction, newEvent),
                                                           returnAction,
                                                           newEvent, 
                                                           false);
        return createAction.invoke(req);
    }
  }
  class ReceiveCreatedEvent extends Action {
      private Action returnAction;
      private Event event;
      public ReceiveCreatedEvent(Servlet s, Action returnAction, Event event) {
          super(s);
          this.returnAction = returnAction;
          this.event = event;
      }
      
      public Page invoke(Request req) throws ServletException {
          // This action is only invoked if the user successfully
          // created the event. So add it to the calendar.
          Main.this.cal.events.add(event);
          return returnAction.invoke(req);
      }      
  }
}

