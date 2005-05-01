package servlet;

/**
 * @author andru
 *
 * A container is an HTML form that starts with a
 * begin tag and ends with an end tag. This class has
 * package scope to prevent arbitrary use.
 */
class Container extends Tag {
    Node contents;
    
    Container(String tag_, Node n) {
        super(tag_, null);
        contents = n;
    }
    
    Container(String tag_, String class_, Node n) {
        super(tag_, class_);
        contents = n;
    }
    
    protected void writeOptions(HTMLWriter p) {
        // default: no options.
    }
    
    protected void writeContents(HTMLWriter p) {
        contents.write(p);
    }
    public void write(HTMLWriter p) {
        super.write(p);
        p.breakLine();
        writeContents(p);
        p.indent(-2);
        p.breakLine();
        p.print("</" + tag + ">");
        p.end();
    }
}
