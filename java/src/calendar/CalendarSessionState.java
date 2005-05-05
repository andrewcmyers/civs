package calendar;

import servlet.SecurityPrincipal;
import servlet.SessionState;

public class CalendarSessionState extends SessionState {
  java.util.Calendar displayDate = null;
  SecurityPrincipal displayUser = null;

  public CalendarSessionState() {
  }
}

