package calendar;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;


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

    public static Date stringToDate(String dateStr) {
        try {
            return df.parse(dateStr);
        }
        catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date");
        }
    }
}
