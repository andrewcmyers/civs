package servlet;

import javax.servlet.ServletException;

/**
 * @author andru
 *
 */
public class Input {
    String name;
    SecurityLabel label;
    
    /** Construct an input with an automatically generated name. */
    // XXX Should take a label argument too.
    public Input(Servlet s) {
        name = "i" + s.nonce.generate().toHex();
        s.addInputName(name);
    }
    
    /** Construct an input with a given name. No two inputs in the same servlet
     * may have the same name. Throws an exception if they do.
     * @param s the servlet
     * @param n the name of the input
     * @throws ServletException
     */
    public Input(String n, Servlet s) throws ServletException {
        s.addInputName(n);
        name = n;
    }
    
    /** @return The name of the input. */
    String getName() {
        return name;
    }
    
    public int hashCode() {
        return name.hashCode();
    }
}
