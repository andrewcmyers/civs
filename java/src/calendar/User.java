package calendar;

/**
 * A User represents a user of the calendar system.
 */
public class User {
  String id;        // The unique ID of the user.
  String name;      // The user's name.
  String password;

  public boolean equals(Object o) {
    return (o instanceof User) && id.equals(((User)o).id);
  }
}

