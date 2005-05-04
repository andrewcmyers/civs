package calendar;

import servlet.Action;

/**
 * A Calendar-specific Action class.
 */
abstract public class CalendarAction extends Action {
  public final Main main;

  public CalendarAction(Main m) {
    super(m);
    this.main = m;
  }

  public CalendarAction(String n, Main m) {
    super(n,m);
    this.main = m;
  }
}

