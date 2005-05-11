package servlet;

import java.util.HashMap;
import java.util.Map;

/**
 * This is a place holder class. Will be replaced with jif.lang.PrincipalUtil.
 */
public class SecurityPrincipalUtil {
    private static Map chainCache = new HashMap();
    
    /**
     * Does the principal p act for the principal q? A synonym for the
     * <code>actsFor</code> method.
     */
    public static boolean acts_for(SecurityPrincipal p, SecurityPrincipal q) {
        return actsFor(p, q);
    }
    /**
     * Does the principal p act for the principal q?
     */
    public static boolean actsFor(SecurityPrincipal p, SecurityPrincipal q) {
        // anyone can act for the "null" principal
        if (q == null) return true;
        
        // if the two principals are ==-equal, or if they
        // both agree that they are equal to each other, then
        // we return true (since the acts-for relation is 
        // reflexive).
        if (p == q) return true;
        if (q.equals(p) && p != null && p.equals(q)) return true;
        
        // try a simple test first
        if (q.delegatesTo(p)) return true;
        
        // try the cache
        PrincipalPair pp = new PrincipalPair(p, q);
        SecurityPrincipal[] chain = (SecurityPrincipal[])chainCache.get(pp);
        if (chain != null) {
            if (verifyChain(chain, p, q)) return true;
            // chain is no longer valid
            chainCache.remove(pp);
        }
        
        // try searching
        chain = findDelegatesChain(p, q);
        if (chain != null && verifyChain(chain, p, q)) {
            // cache the chain to avoid searching later.
            chainCache.put(pp, chain);
            return true;
        }
            
        // can't do anything more!        
        return false;
    }
    
    /**
     * Search for a delegates-chain between p and q. An delegates-chain
     * between p and q is a Principal array <code>a</code> of 
     * length L such that
     *   <pre>
     *     a[L-1] == q
     *     a[L-1] delegates to a[L-2]
     *     ...
     *     a[1] delegates to a[0]
     *     a[0] == p
     *   </pre>.
     *  Thus, a valid delegate chain between p and q implies that p acts for q.
     * @param p
     * @param q
     * @return A delegates-chain between p and q, or null if non can be found.
     */
    public static SecurityPrincipal[] findDelegatesChain(SecurityPrincipal p, SecurityPrincipal q) {
        // try the dumb things first.
        if (p == q) {
            SecurityPrincipal[] chain = new SecurityPrincipal[1];
            chain[0] = p;
            return chain;
        }
        if (q == null || (p != null && p.equals(q) && q.equals(p))) {
            SecurityPrincipal[] chain = new SecurityPrincipal[2];
            chain[0] = p;
            chain[1] = q;
            return chain;
        }
        
        // try searching upwards from q.
        SecurityPrincipal[] chain = q.findChainUpto(p);
        if (chain != null) return chain;

        // try searching downards from p.
        if (p != null) {
            chain = p.findChainDownto(q);
            if (chain != null) return chain;
        }
        
        // have failed!
        return null;
    }

    /**
     * Verify that the chain is a valid delegates-chain between p and q. That is,
     * q == chain[n], chain[n] delegates to chain[n-1], ..., chain[0] == p, i.e.,
     * p acts for q.

     */
    public static boolean verifyChain(SecurityPrincipal[] chain, SecurityPrincipal p, SecurityPrincipal q) {
        if (chain == null || chain.length == 0) return false;
        if (chain[0] != p || chain[chain.length-1] != q) return false;
        
        // now go through the chain and check it
        for (int i = 0; i < chain.length-1; i++) {
            // either i+1 has to be null, or i+1 has to delegate to i
            if (chain[i+1] != null && !chain[i+1].delegatesTo(chain[i])) {
                return false;
            }
        }
        return true;
    }

    private static class PrincipalPair {
        final SecurityPrincipal p;
        final SecurityPrincipal q;
        PrincipalPair(SecurityPrincipal p, SecurityPrincipal q) {
            this.p = p;
            this.q = q;            
        }
        public boolean equals(Object o) {
            if (o instanceof PrincipalPair) {
                PrincipalPair that = (PrincipalPair)o;
                return (this.p == that.p || 
                                  (this.p!=null && that.p!=null && 
                                   this.p.equals(that.p) && that.p.equals(this.p))) &&
                       (this.q == that.q || 
                                   (this.q!=null && that.q!=null && 
                                    this.q.equals(that.q) && that.q.equals(this.q)));                                   
              
            }
            return false;
        }
        public int hashCode() {
            return (p==null?-4234:p.hashCode()) + (q==null?23:q.hashCode());
        }
    }
    
    public static boolean equivalentTo(SecurityPrincipal p, SecurityPrincipal q) {
        return actsFor(p, q) && actsFor(q, p);
    }
    
    /**
     * Obtain a Capability for the given principal and closure.
     */
    public static Capability authorize(SecurityPrincipal p, Object authPrf, Closure c, SecurityLabel lb) {
//        SecurityPrincipal closureP = c.jif$getjif_lang_Closure_P();
//        SecurityLabel closureL = c.jif$getjif_lang_Closure_L();
//        if (closureP == p || (p != null && closureP != null &&
//                p.equals(closureP) && closureP.equals(p))) {
//            // The principals agree.
//            if (closureL != null && closureL.equivalentTo(lb)) {
//                // the labels agree
//                if (p == null || p.isAuthorized(authPrf, c, lb)) {
//                    // either p is null (and the "null" principal always 
//                    // gives authority!) or p grants authority to execute the
//                    // closure.
//                    //return new Capability(closureP, closureL, c);                    
                    return new Capability(c);                    
//                }
//            }
//        }
//        return null;
    }
}
