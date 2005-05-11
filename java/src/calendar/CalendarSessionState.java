package calendar;

import servlet.SessionState;

public class CalendarSessionState extends SessionState {
  java.util.Calendar displayDate = null;
  User displayUser = null;
  User currentUser = null;

  public CalendarSessionState() {
  }
}

