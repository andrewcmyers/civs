package calendar;

import java.util.*;
import servlet.*;

import javax.servlet.ServletException;

public class DoCreateEvent extends CalendarAction {
  private Action returnAction;

  public DoCreateEvent(Main m, Action returnAction) {
      super(m);
      this.returnAction = returnAction;
  }

  /**
   * Returns a new Event, filled out with default values.
   */
  private Event defaultEvent() {
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(Calendar.HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(null);
      Set readers = attendees;
      Set timeReaders = Collections.EMPTY_SET;
      return new Event(start, end, "", "", attendees, null, timeReaders,
	  readers);
  }

  public Page invoke(Request req) throws ServletException {
      Event newEvent = defaultEvent(); 
      CreateEditEvent createAction = new CreateEditEvent(getServlet(),
	  new ReceiveCreatedEvent(getServlet(), returnAction, newEvent),
	  returnAction, newEvent, false);
      return createAction.invoke(req);
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
          main.cal.events.add(event);
          return returnAction.invoke(req);
      }      
  }
}

