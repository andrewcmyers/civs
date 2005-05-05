package servlet;

import java.util.*;

/**
 * A session principal. This principal represents an HTTP session.
 */
public class UserPrincipal extends SecurityPrincipal {
    final String remoteUserID;
    final UserRoleChecker checker;
    UserPrincipal(String remoteUserID, UserRoleChecker checker) {
        this.remoteUserID = remoteUserID;
        this.checker = checker;
    }
    
    public String name() {
        return remoteUserID;
    }

    public boolean actsFor(SecurityPrincipal principal) {
        if (this.equals(principal)) return true;
        if (principal instanceof RolePrincipal) {
            if (checker.isUserInRole(this, (RolePrincipal)principal)) {
                return true;
            }
        }
        // should also check the normal techniques...
        
        return false;
    }    
    
}
