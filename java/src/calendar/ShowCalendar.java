package calendar;

import java.util.*;
import servlet.*;

import java.text.SimpleDateFormat;
import javax.servlet.ServletException;

public class ShowCalendar extends CalendarAction {
  static final int DATE = java.util.Calendar.DATE;
  static final int DAY_OF_WEEK = java.util.Calendar.DAY_OF_WEEK;
  static final int MONTH = java.util.Calendar.MONTH;
  static final int SUNDAY = java.util.Calendar.SUNDAY;
  static final int YEAR = java.util.Calendar.YEAR;

  final Action doCreateEvent;
  final Action setMonth;
  final Input monthInput;
  final Input yearInput;

  public ShowCalendar(Main m) {
    super("show", m);
    doCreateEvent = new CalendarAction(main) {

      /**
       * Returns a new Event, filled out with default values.
       */
      private Event defaultEvent(Request req) {
	SecurityPrincipal currentUser = req.getRemoteUserPrincipal();
	java.util.Calendar c = GregorianCalendar.getInstance();
	Date start = c.getTime();
	c.add(Calendar.HOUR_OF_DAY, 1);
	Date end = c.getTime();
	Set attendees = new HashSet();
	attendees.add(currentUser);
	Set readers = attendees;
	Set timeReaders = Collections.EMPTY_SET;
	return new Event(start, end, "", "", attendees, currentUser,
	    timeReaders, readers);
      }

      public Page invoke(Request req) throws ServletException {
	  Event newEvent = defaultEvent(req); 
	  CreateEditEvent createAction = new CreateEditEvent(main,
	      new FinishEditingEvent(main, newEvent, true), ShowCalendar.this,
	      newEvent, false, true);
	  return createAction.invoke(req);
      }

      protected boolean clearSessionActionsOnInvoke() { return false; }
    };

    try {
      monthInput = new Input("month", servlet);
      yearInput = new Input("year", servlet);
    } catch (ServletException e) {
      throw new RuntimeException(e);
    }

    setMonth =
      new CalendarAction(main) {
	public Page invoke(Request req) throws ServletException {
	  String month = req.getParam(monthInput);
	  String year = req.getParam(yearInput);

	  java.util.Calendar cal =
	    ((CalendarSessionState)req.getSessionState()).displayDate;
	  cal.set(MONTH, new Integer(month).intValue());
	  cal.set(YEAR, new Integer(year).intValue());

	  return ShowCalendar.this.invoke(req);
	}
      };
  }

  public Page invoke(Request req) throws ServletException {
    CalendarSessionState store = (CalendarSessionState)req.getSessionState();

    if (store.displayDate == null) {
	store.displayDate = java.util.GregorianCalendar.getInstance();
    }

    if (store.displayUser == null) {
	store.displayUser = req.getRemoteUserPrincipal();
    }

    java.util.Calendar cal = (java.util.Calendar)store.displayDate.clone();
    cal.add(MONTH, -1);
    String prevMonth = new Integer(cal.get(MONTH)).toString();
    String prevYear = new Integer(cal.get(YEAR)).toString();
    cal.add(MONTH, 2);
    String nextMonth = new Integer(cal.get(MONTH)).toString();
    String nextYear = new Integer(cal.get(YEAR)).toString();

    Map prevMonthInput = new HashMap();
    prevMonthInput.put(monthInput, prevMonth);
    prevMonthInput.put(yearInput, prevYear);

    Map nextMonthInput = new HashMap();
    nextMonthInput.put(monthInput, nextMonth);
    nextMonthInput.put(yearInput, nextYear);

    NodeList content = new NodeList(monthView(req));
    content =
      content.append(new Paragraph(servlet.createRequest(setMonth,
	      prevMonthInput, req, new Text("Previous month"))));
    content =
      content.append(new Paragraph(servlet.createRequest(setMonth,
	      nextMonthInput, req, new Text("Next month"))));
    content =
      content.append(new Paragraph(new Hyperlink(req, doCreateEvent,
	      new Text("Create new event"))));

    return servlet.createPage("My Calendar", content);
  }

  private Node monthView(Request req) {
    // Obtain the session store.
    CalendarSessionState store = (CalendarSessionState)req.getSessionState();
    SecurityPrincipal curUser = req.getRemoteUserPrincipal();

    // Normalize the date argument to fall on midnight.
    Date date = DateUtil.toMidnight(store.displayDate.getTime());

    // Get start date -- the last Sunday on or before the beginning of the
    // month.
    java.util.Calendar c = GregorianCalendar.getInstance();
    c.setTime(date);
    c.set(DATE, 1);
    while (c.get(DAY_OF_WEEK) != SUNDAY) c.add(DATE, -1);
    Date beginDate = c.getTime();

    // Get end date -- the first Sunday of the next month.
    c.setTime(date);
    c.set(DATE, 1);
    c.add(MONTH, 1);
    while (c.get(DAY_OF_WEEK) != SUNDAY) c.add(DATE, 1);
    Date endDate = c.getTime();

    // Construct the body of the calendar.
    SimpleDateFormat sdf =
      new SimpleDateFormat("d"/*, Locale.CHINESE*/);
    NodeList body = NodeList.EMPTY;
    c.setTime(beginDate);
    Date nextDate = c.getTime();  // the next date to be added to the calendar

    // Loop week-by-week until we hit our begin date.
    SimpleDateFormat timeSDF = (SimpleDateFormat)sdf.clone();
    timeSDF.applyPattern("HH:mm");
    while (!endDate.equals(nextDate)) {
      NodeList row = NodeList.EMPTY;
      for (int count = 0; count < 7; count++) {
	Date curDate = nextDate;
	c.add(DATE, 1);
	nextDate = c.getTime();

	NodeList cell = new NodeList(new Text(sdf.format(curDate)));

	// Output events on the current date that we care about.
	Set subSet =
	  main.cal.events.subSet(new Event(curDate), new Event(nextDate));
	List events = new LinkedList();
	for (Iterator it = subSet.iterator(); it.hasNext(); ) {
	  Event e = (Event)it.next();	  
	  if (eventOnPrincipalsCal(store.displayUser, e) && 
	          canPrincipalSeeEventTime(curUser, e)) {
	      cell = cell.append(new Br());
	      boolean canView = canPrincipalSeeEventDetail(curUser, e);
	      String name = canView?e.name:"busy";
	      	  
	      String eventText = timeSDF.format(e.startTime) + " " + name;

	      boolean canEdit = canPrincipalEditEvent(curUser, e); 
	      if (canEdit || canView) {
	          cell =
		    cell.append(new Hyperlink(req,
			  new CreateEditEvent(main,
			    new FinishEditingEvent(main, e, false), this, e,
			    !canEdit, false),
			  new Text(eventText)));
	      } else {
	          cell = cell.append(new Text(eventText));
	      }
	  }
	}

	row = row.append(new TCell(cell));
      }

      body = body.append(new TRow(row));
    }

    // Construct the table header, consisting of the month name and the names
    // of the days of the week.
    sdf.applyPattern("MMMMM yyyy");
    NodeList header =
      new NodeList(new TRow(new TCell(null, new Text(sdf.format(date)), 7,
	      true)));

    sdf.applyPattern("E");
    NodeList dowRow = NodeList.EMPTY;
    for (int count = 0; count < 7; count++) {
      Date curDate = c.getTime();
      c.add(DATE, 1);
      
      dowRow = dowRow.append(new TCell(new Text(sdf.format(curDate))));
    }

    header = header.append(new TRow(dowRow));
    return new Table(header,body);
  }
  
  private boolean eventOnPrincipalsCal(SecurityPrincipal user, Event e) {
      return e.attendees.contains(user);
  }
  
  private boolean canPrincipalEditEvent(SecurityPrincipal user, Event e) {
      return user.equals(e.creator);	  
  }
  
  private boolean canPrincipalSeeEventDetail(SecurityPrincipal user, Event e) {
      return e.attendees.contains(user) || canPrincipalEditEvent(user, e);
  }
  
  private boolean canPrincipalSeeEventTime(SecurityPrincipal user, Event e) {
      return canPrincipalEditEvent(user, e) ||
             canPrincipalSeeEventDetail(user, e) ||
             e.timeReaders.contains(user);
  }

  class FinishEditingEvent extends CalendarAction {
    private Event event;
    private boolean created;
    public FinishEditingEvent(Main s, Event event, boolean created) {
      super(s);
      this.event = event;
      this.created = created;
    }
    
    public Page invoke(Request req) throws ServletException {
      if (created) main.cal.events.add(event);

      CalendarSessionState store = (CalendarSessionState)req.getSessionState();
      store.displayDate.setTime(event.startTime);
      return ShowCalendar.this.invoke(req);
    }      
  }
}

