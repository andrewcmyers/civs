package calendar;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;


public class DateUtil {
    static final DateFormat df;

    static {
      df = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
      df.setLenient(true);        
    }

    public static String dateToString(Date date) {
        return df.format(date);
    }

    public static boolean isDate(String dateStr) {
        try {
            df.parse(dateStr);
            return true;
        }
        catch (ParseException e) {
            return false;
        }
    }

    /**
     * Returns a Date representing 00:00:00 on the given Date.
     */
    public static Date toMidnight(Date date) {
      Calendar c = GregorianCalendar.getInstance();
      c.setTime(date);
      c.clear(Calendar.HOUR_OF_DAY);
      c.clear(Calendar.MINUTE);
      c.clear(Calendar.SECOND);
      c.clear(Calendar.MILLISECOND);
      return c.getTime();
    }

    public static Date stringToDate(String dateStr) {
        try {
            return df.parse(dateStr);
        }
        catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date");
        }
    }
}
