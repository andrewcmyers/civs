package servlet;

/**
 * A security principal. This is a place holder, and when we integrate with
 * Jif should be replaced with jif.lang.Principal and/or jif.lang.AbstractPrincipal, 
 * that is, Jif's runtime 
 * representation of principals. May need to revisit the implementation
 * of Jif's principals to allow the correct implementation of actsfor. 
 */
public abstract class SecurityPrincipal {
    private String name;
    
    protected SecurityPrincipal[] superiors = null;
    
    public String name() { return name; }
    
    public boolean delegatesTo(final SecurityPrincipal p) { return superiorsContains((SecurityPrincipal) p); }
    
    public void addDelegatesTo(final SecurityPrincipal p) {
        if (superiorsContains((SecurityPrincipal) p)) { return; }
        try {
            if (superiors == null) {
                superiors = (new SecurityPrincipal[1]);
                superiors[0] = (SecurityPrincipal) p;
            } else {
                SecurityPrincipal[] old = superiors;
                superiors = (new SecurityPrincipal[old.length + 1]);
                for (int i = 0; i < old.length; i++) { superiors[i] = old[i]; }
                superiors[old.length] = (SecurityPrincipal) p;
            }
        }
        catch (final NullPointerException impossible) {  }
        catch (final ArrayStoreException impossible) {  }
        catch (final ArrayIndexOutOfBoundsException impossible) {  }
    }
    
    protected boolean superiorsContains(final SecurityPrincipal p) {
        boolean result = false;
        SecurityPrincipal[] sprs = superiors;
        for (int i = 0; sprs != null && i < sprs.length; i++) {
            try {
                SecurityPrincipal pi = sprs[i];
                if (p == pi || pi != null && pi.equals(p)) {
                    result = true;
                    break;
                }
            }
            catch (final ArrayIndexOutOfBoundsException impossible) {  }
        }
        return result;
    }
    
    public boolean isAuthorized(final Object authPrf, final Closure closure, final SecurityLabel lb) { return false; }
    
    public SecurityPrincipal[] findChainDownto(final SecurityPrincipal q) { return null; }
    
    public SecurityPrincipal[] findChainUpto(final SecurityPrincipal p) {
        int d = 0;
        SecurityPrincipal[] chain;
        SecurityPrincipal[] sprs = superiors;
        for (int i = 0; sprs != null && i < sprs.length; i++) {
            try {
                SecurityPrincipal s = sprs[i];
                chain = SecurityPrincipalUtil.findDelegatesChain(p, s);
                if (chain != null) { return addToChainBottom(chain, this, d); }
            }
            catch (final ArrayIndexOutOfBoundsException impossible) {  }
        }
        return null;
    }
    
    public boolean equals(final Object o) {
        if (o == null) return false;
        if (o instanceof SecurityPrincipal) {
            try {
                return equals((SecurityPrincipal) o);
            }
            catch (final ClassCastException impossible) {  }
        }
        return false;
    }
    
    public boolean equals(final SecurityPrincipal p) {
        if (p == null) return false;
        return (this.name == p.name() || this.name != null && this.name.equals(p.name())) &&
          this.getClass() == p.getClass();
    }
    
    public int hashCode() {
        if (name == null) return -382389;
        return name.hashCode();
    }
    
    protected static SecurityPrincipal[] addToChainBottom(final SecurityPrincipal[] chain, final SecurityPrincipal p, final int dummy) {
        if (chain == null) {
            SecurityPrincipal[] newChain = new SecurityPrincipal[1];
            try {
                newChain[0] = p;
            }
            catch (final ArrayStoreException impossible) {  }
            catch (final ArrayIndexOutOfBoundsException impossible) {  }
            return newChain;
        }
        SecurityPrincipal[] newChain = new SecurityPrincipal[chain.length + 1];
        try {
            for (int i = 0; i < chain.length; i++) { newChain[i] = chain[i]; }
            newChain[chain.length] = p;
        }
        catch (final ArrayStoreException impossible) {  }
        catch (final ArrayIndexOutOfBoundsException impossible) {  }
        return newChain;
    }
    
    protected static SecurityPrincipal[] addToChainTop(final SecurityPrincipal p, final SecurityPrincipal[] chain, final int dummy) {
        if (chain == null) {
            SecurityPrincipal[] newChain = new SecurityPrincipal[1];
            try {
                newChain[0] = p;
            }
            catch (final ArrayStoreException impossible) {  }
            catch (final ArrayIndexOutOfBoundsException impossible) {  }
            return newChain;
        }
        SecurityPrincipal[] newChain = new SecurityPrincipal[chain.length + 1];
        try {
            newChain[0] = p;
            for (int i = 0; i < chain.length; i++) { newChain[i + 1] = chain[i]; }
        }
        catch (final ArrayStoreException impossible) {  }
        catch (final ArrayIndexOutOfBoundsException impossible) {  }
        return newChain;
    }
      
}