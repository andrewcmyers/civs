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
  static final int MONTH = java.util.Calendar.MONTH;
  static final int SUNDAY = java.util.Calendar.SUNDAY;
  static final int SATURDAY = java.util.Calendar.SATURDAY;

  synchronized Node monthToNode(User reader, User user, Date date) {
    java.util.Calendar c = GregorianCalendar.getInstance();

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
    c.add(DATE, -1);
    while (c.get(DAY_OF_WEEK) != SATURDAY) c.add(DATE, 1);
    Date endDate = c.getTime();

    // Construct the body of the calendar.  We do this backwards because of
    // the inconvenient NodeList interface.
    SimpleDateFormat sdf = new SimpleDateFormat("d");
    NodeList body = null;
    c.setTime(endDate);
    Date curDate = c.getTime();  // the next date to add to the calendar
    while (!beginDate.after(curDate)) {
      NodeList row = null;
      for (int count = 0; count < 7; count++) {
	row = new NodeList(new TCell(new Text(sdf.format(curDate))), row);
	c.add(DATE, -1);
	curDate = c.getTime();
      }

      body = new NodeList(new TRow(row), body);
    }

    // Construct the table header, consisting of the month name and the names
    // of the days of the week.
    sdf.applyPattern("E");
    NodeList dowRow = null;
    for (int count = 0; count < 7; count++) {
      dowRow = new NodeList(new TCell(new Text(sdf.format(curDate))), dowRow);
      c.add(DATE, -1);
      curDate = c.getTime();
    }

    sdf.applyPattern("MMMMM");
    NodeList header = new NodeList(
	new TRow(new TCell(null, new Text(sdf.format(date)), 7, true)),
	new TRow(dowRow));

    return new Table(header,body);//new Text("start=" + beginDate + ", end=" + endDate);
  }
}
