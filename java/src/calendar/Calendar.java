package calendar;

import java.util.*;
import servlet.*;
import java.text.SimpleDateFormat;

/**
 * A Calendar holds the persistent state of the entire calendar system.
 */
public class Calendar {
  Set users;
  SortedSet events;

  static final int DATE = java.util.Calendar.DATE;
  static final int DAY_OF_WEEK = java.util.Calendar.DAY_OF_WEEK;
  static final int HOUR_OF_DAY = java.util.Calendar.HOUR_OF_DAY;
  static final int MILLISECOND = java.util.Calendar.MILLISECOND;
  static final int MINUTE = java.util.Calendar.MINUTE;
  static final int MONTH = java.util.Calendar.MONTH;
  static final int SATURDAY = java.util.Calendar.SATURDAY;
  static final int SECOND = java.util.Calendar.SECOND;
  static final int SUNDAY = java.util.Calendar.SUNDAY;

  public static Event createTestSecretEvent() {
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(null);
      Set readers = Collections.EMPTY_SET;
      Set timeReaders = Collections.EMPTY_SET;
      return new Event(start, end, "sekrit", "", attendees, null,
  	  timeReaders, readers);      
  }
  public static Event createTestPartialSecretEvent() {
      // A partially visible event.
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(null);
      Set timeReaders = attendees;
      Set readers = Collections.EMPTY_SET;
      return (new Event(start, end, "sleep", "", attendees, null,
  	  timeReaders, readers));      
  }
  public static Event createTestPublicEvent() {
      // A totally visible event.
      java.util.Calendar c = GregorianCalendar.getInstance();
      Date start = c.getTime();
      c.add(HOUR_OF_DAY, 1);
      Date end = c.getTime();
      Set attendees = new HashSet();
      attendees.add(null);
      Set timeReaders = Collections.EMPTY_SET;
      Set readers = attendees;
      return (new Event(start, end, "work", "", attendees, null,
  	  timeReaders, readers));
      
  }
  public static Event createTestMultidayEvent() {
      // A multi-day event.
      java.util.Calendar c = GregorianCalendar.getInstance();
      c.add(DATE, -3);
      Date start = c.getTime();
      c.add(DATE, 6);
      Date end = c.getTime();
      Set timeReaders = Collections.EMPTY_SET;
      Set attendees = new HashSet();
      attendees.add(null);
      Set readers = attendees;
      return (new Event(start, end, "work", "", attendees, null,
  	  timeReaders, readers));
  }
  public Calendar() {
    users = new HashSet();
    events = new TreeSet();

    // XXX Add some events to test -- some ugly fragile code

    events.add(createTestSecretEvent());
    events.add(createTestPartialSecretEvent());
    events.add(createTestPublicEvent());
    events.add(createTestMultidayEvent());
  }

  /**
   * @@@@Should be moved. This is presentation code, and the Calendar class is
   * a data object (i.e., will be stored in persistent storage.)
   */
  synchronized Node monthToNode(User reader, User user, Date date) {
    java.util.Calendar c = GregorianCalendar.getInstance();

    // Normalize the date argument to fall on midnight.
    c.setTime(date);
    c.clear(HOUR_OF_DAY);
    c.clear(MINUTE);
    c.clear(SECOND);
    c.clear(MILLISECOND);
    date = c.getTime();

    // Get start date -- the last Sunday on or before the beginning of the
    // month.
    c.setTime(date);
    c.set(DATE, 1);
    while (c.get(DAY_OF_WEEK) != SUNDAY) c.add(DATE, -1);
    Date beginDate = c.getTime();

    // Get get end date -- the first Saturday on or after the end of the
    // month.
    c.setTime(date);
    c.set(DATE, 1);
    c.add(MONTH, 1);
    while (c.get(DAY_OF_WEEK) != SUNDAY) c.add(DATE, 1);
    Date endDate = c.getTime();

    // Construct the body of the calendar.  We do this backwards because of
    // the inconvenient NodeList interface.
    SimpleDateFormat sdf =
      new SimpleDateFormat("d"/*, Locale.CHINESE*/);
    NodeList body = null;
    c.setTime(endDate);
    Date curDate = c.getTime();  // the date we last added to the calendar

    // Loop week-by-week until we hit our begin date.
    SimpleDateFormat timeSDF = (SimpleDateFormat)sdf.clone();
    timeSDF.applyPattern("KK:mm");
    while (!beginDate.equals(curDate)) {
      NodeList row = null;
      for (int count = 0; count < 7; count++) {
	c.add(DATE, -1);
	Date prevDate = curDate;
	curDate = c.getTime();

	// Construct a list of events on the current date that we care about.
	Set subSet = events.subSet(new Event(curDate), new Event(prevDate));
	List events = new LinkedList();
	for (Iterator it = subSet.iterator(); it.hasNext(); ) {
	  Event e = (Event)it.next();
	  if (e.timeReaders.contains(reader) && e.attendees.contains(user)) {
	    events.add(e);
	  }
	}

	NodeList cell = null;
	// Output events list backwards.
	for (ListIterator it = events.listIterator(events.size());
	    it.hasPrevious(); ) {
	  Event e = (Event)it.previous();
	  String name = "Busy";
	  if (e.readers.contains(reader)) name = e.name;
	      
	  String eventText = timeSDF.format(e.startTime) + " " + name;
	  boolean canEdit = false; // @@@@hack. SHould be checked
	      
	  if (canEdit) {
	      // @@@ Need access to the servlet, and to the ShowCalendar action.
//	      cell = new NodeList(new Hyperlink(new CreateEditEvent(main, this, this, e, false),
//	                                        new Text(eventText)), cell);	      	      
	  }
	  else {
	      cell = new NodeList(new Text(eventText), cell);	      
	  }

	  cell = new NodeList(new Br(), cell);
	}

	cell = new NodeList(new Text(sdf.format(curDate)), cell);
	row = new NodeList(new TCell(cell), row);
      }

      body = new NodeList(new TRow(row), body);
    }

    // Construct the table header, consisting of the month name and the names
    // of the days of the week.
    sdf.applyPattern("E");
    NodeList dowRow = null;
    for (int count = 0; count < 7; count++) {
      c.add(DATE, -1);
      curDate = c.getTime();
      
      dowRow = new NodeList(new TCell(new Text(sdf.format(curDate))), dowRow);
    }

    sdf.applyPattern("MMMMM");
    NodeList header = new NodeList(
	new TRow(new TCell(null, new Text(sdf.format(date)), 7, true)),
	new TRow(dowRow));

    return new Table(header,body);
  }
}
