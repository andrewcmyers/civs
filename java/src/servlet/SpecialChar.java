package servlet;

/**
 * A special character, e.g. "&nbsp;" or "&#8211;"
 */
public class SpecialChar extends Node {
    String name;

    public SpecialChar(String n) {
        name = n;
        for (int i = 0; i < n.length(); i++) {
            if (!Character.isLetterOrDigit(n.charAt(i)))
                throw new IllegalArgumentException("Invalid character in special character name");
        }
    }
    public SpecialChar(int n) {
        name = "#" + n;
    }
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.print("&");
        p.print(name);
        p.print(";");
    }

}
