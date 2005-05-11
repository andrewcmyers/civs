package calendar;

/**
 * Represents a user, as would be found in a database. 
 */
public class User {
    /**
     * email address is the primary key of the user
     */
    private String emailAddress;
    
    private String firstName;
    private String lastName;
    private String password; // XXX should be a secure hash of it 

    public User(String emailAddress) {
        this.emailAddress = emailAddress;
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

    public String getEmailAddress() {
        return emailAddress;
    }
    
    public String toString() {
        return firstName + " " + lastName;
    }

}
