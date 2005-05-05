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
  private Event defaultEvent(Request req) {
      SecurityPrincipal currentUser = req.getRemoteUserPrincipal();
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(Calendar.HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(currentUser);
      Set readers = attendees;
      Set timeReaders = Collections.EMPTY_SET;
      return new Event(start, end, "", "", attendees, currentUser, timeReaders,
	  readers);
  }

  public Page invoke(Request req) throws ServletException {
      Event newEvent = defaultEvent(req); 
      CreateEditEvent createAction = new CreateEditEvent(main,
	  new ReceiveCreatedEvent(main, returnAction, newEvent),
	  returnAction, newEvent, false, true);
      return createAction.invoke(req);
  }

  protected boolean clearSessionActionsOnInvoke() { return false; }

  class ReceiveCreatedEvent extends CalendarAction {
      private Action returnAction;
      private Event event;
      public ReceiveCreatedEvent(Main s, Action returnAction, Event event) {
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

