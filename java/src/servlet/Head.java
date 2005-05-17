package servlet;

/**
 * The head of an HTML page.
 */
public class Head extends Node {
    String title;
    String styleFile;
    String scriptFile = null;
    
    /** Create a page head. Non-public to allow servlet to control
     *  creation through the createHead() method.
     * @param t The page title
     * @param s The URL of the style file. May be null to signal absence.
     */	 
    Head(String t, String s) {
        title = t;
        styleFile = s;
    }
    /** Create a page head.
     * @param script the name of a Javascript file. */ 
    Head(String t, String styleFile, String script) {
        this(t, styleFile);
        scriptFile = script;
    }
    public void write(HTMLWriter w) {
        w.begin(2);
        w.print("<head>");
        w.unifiedBreak();
        w.print("<title>");
        w.escape(title);
        w.print("</title>");
        
        if (styleFile != null) {
            w.unifiedBreak();
            w.print("<link ");
            w.begin();
            w.print("rel=\"stylesheet\"");
            w.unifiedBreak();
            w.print("type=\"text/css\"");
            w.unifiedBreak();
            w.print("href=");
            w.printq(styleFile);
            w.unifiedBreak();
            w.print("type=\"text/css\"");
            w.unifiedBreak();
            w.print("/>");
            w.end();
        }
        if (scriptFile != null) {
            w.unifiedBreak();
            w.begin();
            w.print("<script");
            w.allowBreak(0, 2, " ");
            w.begin();
            w.print("language=\"JavaScript\"");
            w.unifiedBreak();
            w.print("type=\"text/javascript\"");
            w.unifiedBreak();
            w.print("src=");
            w.printq(scriptFile);
            w.allowBreak(0, 2, " ");
            w.print("></script>");
            w.end();
        }
        w.end();
        w.breakLine();
        w.print("</head>");
        w.breakLine();
    }
}
