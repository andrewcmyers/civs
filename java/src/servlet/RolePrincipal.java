package servlet;

/**
 * A session principal. This principal represents an HTTP session.
 */
public class RolePrincipal extends SecurityPrincipal {
    final String roleName;
    RolePrincipal(String roleName) {
        this.roleName = roleName;
    }
    
    public String name() {
        return roleName;
    }
    public boolean actsFor(SecurityPrincipal principal) {
        return (this.equals(principal));
    }    
    
}
