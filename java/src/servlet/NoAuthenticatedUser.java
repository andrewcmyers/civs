package servlet;

/**
 * Exception thrown when a User Principal is needed, but there
 * is not authenticated user.
 */
public class NoAuthenticatedUser extends RuntimeException {
    public NoAuthenticatedUser() {
        super();
    }

    public NoAuthenticatedUser(String message) {
        super(message);
    }

}
