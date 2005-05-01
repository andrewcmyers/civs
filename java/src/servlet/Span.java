package servlet;

/**
 * @author andru
 *
 * A span is a way of attaching a CSS class to a
 * bunch of text. This is useful for applying formatting.
 * The assumption is that all formatting will be done
 * through style sheets rather than explicit <b>, <i>, etc.
 */
public class Span extends Container {
    String class_;
    public Span(String class_, Node n) {
        super("span", class_, n);
        this.class_ = class_;
    }
    /** A useful version of the constructor that
     *  automatically constructs a text node.
     * @param class_
     * @param text
     */
    public Span(String class_, String text) {
        this(class_, new Text(text));
    }
}
