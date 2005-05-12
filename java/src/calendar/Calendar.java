package calendar;

import java.util.*;

/**
 * A Calendar holds the persistent state of the entire calendar system.
 */
public class Calendar {
  Map users; // map from userIDs to User objects.
  SortedSet events;

  static final int DATE = java.util.Calendar.DATE;
  static final int HOUR_OF_DAY = java.util.Calendar.HOUR_OF_DAY;

  public Calendar() {
    users = new HashMap();
    events = new TreeSet();
    
    // XXX test code. Should have persistent storage.
    initializeUsers();
  }

  private void initializeUsers() {
      addUser("liujed", "password", "Jed", "Liu");
      addUser("andru", "password", "Andrew", "Myers");
      addUser("schong", "password", "Steve", "Chong");
  }

  private void addUser(String userID, String password, String firstName,
      String lastName) {
    User u = new User(userID);
    u.setFirstName(firstName);
    u.setLastName(lastName);
    u.setPassword(password);
    users.put(userID, u);
  }
}
