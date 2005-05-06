package servlet;

/**
 * A security principal. This is a place holder, and when we integrate with
 * Jif should be replaced with jif.lang.Principal, that is, Jif's runtime 
 * representation of principals. May need to revisit the implementation
 * of Jif's principals to allow the correct implementation of actsfor. 
 */
public abstract class SecurityPrincipal {
    /** XXX Seems to me that actedForBy should be the primitive
     * overridden thing here, and actsFor a final method --AM
     * @param principal
     * @return whether the principal <code>p</code> acts for <code>this</code>.
     */
    public abstract boolean actsFor(SecurityPrincipal p);
    
    /** XXX This is (should be) an abstract method that different kinds of principals
     * can override to capture their delegation of authority.
     * @param p
     * @return whether the principal <code>p</code> acts for this
     * principal.
     */
    public boolean actedForBy(SecurityPrincipal p) {
        return p.actsFor(this);
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
