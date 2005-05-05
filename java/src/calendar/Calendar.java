package calendar;

import java.util.*;

/**
 * A Calendar holds the persistent state of the entire calendar system.
 */
public class Calendar {
  Set users;
  SortedSet events;

  static final int DATE = java.util.Calendar.DATE;
  static final int HOUR_OF_DAY = java.util.Calendar.HOUR_OF_DAY;

  public Calendar() {
    users = new HashSet();
    events = new TreeSet();

//    // XXX Add some events to test -- some ugly fragile code
//
//    events.add(createTestSecretEvent());
//    events.add(createTestPartialSecretEvent());
//    events.add(createTestPublicEvent());
//    events.add(createTestMultidayEvent());
  }

//  public static Event createTestSecretEvent() {
//      java.util.Calendar c = GregorianCalendar.getInstance();
//      Date start = c.getTime();
//      c.add(HOUR_OF_DAY, 1);
//      Date end = c.getTime();
//      Set attendees = new HashSet();
//      attendees.add(null);
//      Set readers = Collections.EMPTY_SET;
//      Set timeReaders = Collections.EMPTY_SET;
//      return new Event(start, end, "sekrit", "", attendees, null, timeReaders, readers);      
//  }
//
//  public static Event createTestPartialSecretEvent() {
//      // A partially visible event.
//      java.util.Calendar c = GregorianCalendar.getInstance();
//      Date start = c.getTime();
//      c.add(HOUR_OF_DAY, 1);
//      Date end = c.getTime();
//      Set attendees = new HashSet();
//      attendees.add(null);
//      Set timeReaders = attendees;
//      Set readers = Collections.EMPTY_SET;
//      return (new Event(start, end, "sleep", "", attendees, null,
//  	  timeReaders, readers));      
//  }
//
//  public static Event createTestPublicEvent() {
//      // A totally visible event.
//      java.util.Calendar c = GregorianCalendar.getInstance();
//      Date start = c.getTime();
//      c.add(HOUR_OF_DAY, 1);
//      Date end = c.getTime();
//      Set attendees = new HashSet();
//      attendees.add(null);
//      Set timeReaders = Collections.EMPTY_SET;
//      Set readers = attendees;
//      return (new Event(start, end, "work", "", attendees, null,
//  	  timeReaders, readers));
//      
//  }
//
//  public static Event createTestMultidayEvent() {
//      // A multi-day event.
//      java.util.Calendar c = GregorianCalendar.getInstance();
//      c.add(DATE, -3);
//      Date start = c.getTime();
//      c.add(DATE, 6);
//      Date end = c.getTime();
//      Set timeReaders = Collections.EMPTY_SET;
//      Set attendees = new HashSet();
//      attendees.add(null);
//      Set readers = attendees;
//      return (new Event(start, end, "work", "", attendees, null,
//  	  timeReaders, readers));
//  }
}
