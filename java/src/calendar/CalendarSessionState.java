package calendar;

import servlet.SessionState;

public class CalendarSessionState extends SessionState {
  java.util.Calendar date;

  public CalendarSessionState() {
    date = java.util.GregorianCalendar.getInstance();
  }
}

