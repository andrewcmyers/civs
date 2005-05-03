package calendar;

import java.util.*;
import servlet.*;

import javax.servlet.ServletException;

public class DoCreateEvent extends CalendarAction {
  private Action returnAction;

  // Maps returnActions to memoized DoCreateEvents.
  private static final Map memoized = new HashMap();

  public DoCreateEvent(Main m, Action returnAction) {
      super(m);
      this.returnAction = returnAction.intern();
  }

  public boolean equivalentTo(Action a) {
    return (a instanceof DoCreateEvent)
      && (((DoCreateEvent)a).returnAction.equivalentTo(returnAction));
  }

  public Action intern() {
    if (memoized.containsKey(returnAction))
      return (Action)memoized.get(returnAction);

    memoized.put(returnAction, this);
    return this;
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
      attendees.add(Main.USER);
      Set readers = attendees;
      Set timeReaders = Collections.EMPTY_SET;
      return new Event(start, end, "", "", attendees, Main.USER, timeReaders,
	  readers);
  }

  public Page invoke(Request req) throws ServletException {
      Event newEvent = defaultEvent(); 
      CreateEditEvent createAction = new CreateEditEvent(main,
	  new ReceiveCreatedEvent(main, returnAction, newEvent),
	  returnAction, newEvent, false, true);
      return createAction.invoke(req);
  }

  class ReceiveCreatedEvent extends CalendarAction {
      private Action returnAction;
      private Event event;
      public ReceiveCreatedEvent(Main s, Action returnAction, Event event) {
          super(s);
          this.returnAction = returnAction;
          this.event = event;
      }

      public boolean equivalentTo(Action a) {
	return false;
      }

      public Action intern() {
	return this;
      }
      
      public Page invoke(Request req) throws ServletException {
          // This action is only invoked if the user successfully
          // created the event. So add it to the calendar.
          main.cal.events.add(event);
          return returnAction.invoke(req);
      }      
  }
}

