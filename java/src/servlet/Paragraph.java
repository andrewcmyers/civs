package servlet;

/**
 * @author andru
 *
 * A Paragraph is an HTML paragraph.
 */
public class Paragraph extends BlockContainer {
    public Paragraph(Node n) {
        super("p", n);
    }
}
