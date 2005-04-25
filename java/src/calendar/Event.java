package calendar;

import java.util.Date;
import java.util.Set;

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
  Set timeReaders;  // Users who can read start/end time.
  Set readers;      // Users who can read all details.

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

