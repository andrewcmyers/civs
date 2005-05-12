package calendar;

/**
 * Represents a user, as would be found in a database. 
 */
public class User {
    /**
     * email address is the primary key of the user
     */
    private String userID;
    
    private String firstName;
    private String lastName;
    private String password; // XXX should be a secure hash of it 

    public User(String userID) {
        this.userID = userID;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public String toString() {
        return firstName + " " + lastName;
    }

    public String getUserID() {
        return userID;
    }

}
