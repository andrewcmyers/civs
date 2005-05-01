package servlet;

/**
 * A Tag represents an HTML node that has a tag.
 * It may or may not have a corresponding end tag.
 **/
public class Tag extends Node {	
    String tag;
    String class_;
    
    public Tag(String t, String c) {
        tag = t;
        class_ = c;
    }
    
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.begin();
        p.indent(2);
        p.print("<");
        p.print(tag);
        if (class_ != null || p.currentClass() != null) {
            p.print(" class=");
            if (class_ != null) {
                p.printq(class_);
            } else {
                p.printq(p.currentClass());
            }
            p.setClass(null);
        }
        writeOptions(p);
        p.print(">");
    }
    
    protected void writeOptions(HTMLWriter p) {}
    
    public Tag setClass(String c) {
        class_ = c;
        return this;    	
    }
}
