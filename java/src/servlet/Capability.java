package servlet;

public final class Capability {
//    private final SecurityPrincipal jif$jif_lang_Capability_P;    
//    private final SecurityLabel jif$jif_lang_Capability_L;    
    private final Closure closure;
    
    public Closure getClosure() { return closure; }
    
    public Object invoke() {
        if (closure == null) return null;
        return closure.invoke();
    }       
    
//    Capability(final Principal jif$P, final Label jif$L, final Closure closure) {
      Capability(final Closure closure) {
        super();
//        this.jif$jif_lang_Capability_P = jif$P;
//        this.jif$jif_lang_Capability_L = jif$L;
        this.closure = closure;
    }
    
//    public static boolean jif$Instanceof(final Principal jif$P, final Label jif$L, final Object o) {
//        if (o instanceof Capability) {
//            Capability c = (Capability) o;
//            boolean ok = true;
//            ok = ok && PrincipalUtil.equivalentTo(c.jif$jif_lang_Capability_P, jif$P);
//            ok = ok && c.jif$jif_lang_Capability_L.equivalentTo(jif$L);
//            return ok;
//        }
//        return false;
//    }
//    
//    public static Capability jif$cast$jif_lang_Capability(final Principal jif$P, final Label jif$L, final Object o) {
//        if (jif$Instanceof(jif$P, jif$L, o)) return (Capability) o;
//        throw new ClassCastException();
//    }    
}
