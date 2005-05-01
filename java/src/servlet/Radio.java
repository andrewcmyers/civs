
package servlet;

/**
 * To create radio buttions, a Radio is needed.
 */
public class Radio {
    Name name;
    public Radio(Servlet s) {
        name = s.nonce.generate();
    }
}
