package servlet;

/**
 * A Tag represents an HTML node that has a tag.
 * It may or may not have a corresponding end tag.
 **/
public class Tag extends Node {	
    String tag;
    String class_;
    String id;
    
    public Tag(String t, String c) {
        tag = t;
        class_ = c;
    }
    
    /** Write out the tag, including an unmatched
     * p.begin().
     * @param p
     */
    public void writeTag(HTMLWriter p) {
        p.begin(2);
        p.print("<");
        p.print(tag);
        p.allowBreak(0, 2, " ");
        p.begin(1);
        if (class_ != null || p.currentClass() != null) {
            p.print("class=");
            if (class_ != null) {
                p.printq(class_);
            } else {
                p.printq(p.currentClass());
            }
            p.setClass(null);
        }
        if (id != null) {
            p.allowBreak();
            p.print("id=");
            p.printq(id);
        }
        writeOptions(p);
        p.end();
        p.print(">");
    }
    /** Write everything after the tag. Must include
     * an extra p.end() to match writeTag(). */
    public void writeRest(HTMLWriter p) {}
    
    public void write(HTMLWriter p) {
        p.begin();
        writeTag(p);
        writeRest(p);
        p.end();
    }
    
    /** Write everything inside the tag after the tag name itself. */
    protected void writeOptions(HTMLWriter p) {}
    
    public Tag setClass(String c) {
        class_ = c;
        return this;    	
    }
    
    public Tag setId(String id_) {
        id = id_;
        return this;
    }
}
