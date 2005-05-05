package servlet;

import java.util.Iterator;
import java.util.Set;

/**
 * A security principal. This is a place holder, and when we integrate with
 * Jif should be replaced with jif.lang.Principal, that is, Jif's runtime 
 * representation of principals. May need to revisit the implemenation
 * of Jif's principals to allow the correct implementation of actsfor. 
 */
public abstract class SecurityPrincipal {
    public abstract boolean actsFor(SecurityPrincipal principal);
    public boolean actedForBy(SecurityPrincipal principal) {
        return principal.actsFor(this);
    }
    public final boolean equivalentTo(SecurityPrincipal principal) {
        return this.actsFor(principal) && principal.actsFor(this);
    }
    public String fullName() {
        return name();
    }
    public abstract String name();
    public boolean equals(Object obj) {
        if (obj instanceof SecurityPrincipal) {
            return this.fullName().equals(((SecurityPrincipal)obj).fullName());
        }
        return false;
    }
    
    public int hashCode() {
        return fullName().hashCode();
    }
    
}
