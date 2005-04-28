package calendar;

import java.util.*;

/**
 * An Event represents an entry in the calendar system.  A single Event object
 * is shared amongst all users involved in that event.
 *
 * Note: this class has a natural ordering that is inconsistent with equals.
 */
public class Event implements Comparable {
  Date startTime;
  Date endTime;
  String name;
  String note;
  Set attendees;
  User creator;

  // Access control
  Set timeReaders;  // Users who can read start/end time and attendees.
  Set readers;      // Users who can read all details.

  Event(Date date) {
    this(date, date, null, null, Collections.EMPTY_SET, null,
	Collections.EMPTY_SET, Collections.EMPTY_SET);
  }

  public Event(Date startTime, Date endTime, String name, String note,
      Set attendees, User creator, Set timeReaders, Set readers) {
    this.startTime = startTime;
    this.endTime = endTime;
    this.name = name;
    this.note = note;
    this.attendees = new HashSet(attendees);
    this.creator = creator;
    this.timeReaders = new HashSet(timeReaders);
    this.readers = new HashSet(readers);

    this.timeReaders.addAll(this.readers);
  }

  /**
   * Compares Events by start time.
   */
  public int compareTo(Object o) {
    if (o instanceof Event) {
      Event e = (Event)o;
      return startTime.compareTo(e.startTime);
    }

    return 0;
  }
}

