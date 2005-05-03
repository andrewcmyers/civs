package servlet;

/**
 * @author andru
 *
 * A container that is a block-level element like a
 * paragraph, and hence can have a line break placed
 * safely before or after it in the HTML.
 */
public class BlockContainer extends Container {
    BlockContainer(String tag, Node body) {
        super(tag, body);
    }
    BlockContainer(String tag, String class_, Node body) {
        super(tag, class_, body);
    }
    
    public void writeTag(HTMLWriter p) {
        p.allowBreak(); super.writeTag(p);
    }
    public void write(HTMLWriter p) {
        super.write(p);
        p.breakLine();
    }
}
