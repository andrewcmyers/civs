package servlet;

import java.util.Stack;
import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * @author andru
 * 
 * A class for generating indented output. Has begin() and end() to indicate
 * structure. Does not try to optimize line breaking or anything fancy.
 */
public class HTMLWriter {
    int indent = 0;
    boolean verbatim = false;
    String currentClass = null;
    int pos = 0;  // if pos == 0, the line is empty so far.
    public static final int MAX_WIDTH = 80;
    public static final int TRIGGER_COLUMN = 72;
    Stack s = new Stack();
    
    PrintWriter writer;
    
    public HTMLWriter(PrintWriter p) {
        writer = p;
    }
    public void print(String s) {
        if (pos == 0) doIndent();
        pos += s.length();
        if (verbatim || pos <= MAX_WIDTH) {
            writer.print(s);
        } else {
            for (int i = 0; i < s.length(); i++) {
                char c = s.charAt(i);
                if (Character.isWhitespace(c)) {
                    breakLine();
                } else {
                    doIndent();
                    writer.print(c);
                }
            }
        }
    }
    public void allowBreak() {
        if (pos >= TRIGGER_COLUMN) breakLine();
    }
    public void print(int i) {
        print(Integer.toString(i));
    }
    /* Output s verbatim with quotes around it. */
    public void printq(String s) {
        boolean tmp = verbatim;
        verbatim = true;
        print("\"");
        escape(s);
        print("\"");
        verbatim = tmp;
    }
    public void printq(int i) {
        printq(Integer.toString(i));
    }
    public void breakLine() {
        if (pos != 0) {
            writer.print("\r\n");
            pos = 0;
            //writer.print("<!-- indent = " + indent + "-->");
        }
    }
    private void doIndent() {
        if (pos == 0 && !verbatim) {
            for (int i = 0; i < indent; i++) {
                writer.print(" ");
            }
            pos = indent;
        }
    }
    public void indent(int n) {
        indent += n;
    }
    
    public void begin() {
        s.push(new Integer(indent));
        if (pos != 0) indent = pos;
    }
    
    public void end() {
        indent = ((Integer)s.pop()).intValue();
    }
    
    public void noindent(boolean b) {
        verbatim = b;
    }
    
    public void close() {
        writer.close();
    }
    
    /** Escape HTML special characters in s and
     * print the result. */
    
    static char[] hex = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    public void escape(String s) {
        doIndent();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
            case '&':
                print("&amp;");
                break;					
            case '<':
                print("&lt;");
                break;
            case '>':
                print("&gt;");
                break;
            case ' ':
                if (verbatim || pos <= MAX_WIDTH - 8) {
                    writer.print(c);
                    pos++;
                } else {
                    breakLine();
                }
                break;
            default:
                int code = (int)c;
            	if (code >= 0x21 && code <= 0x7E) {
            	    doIndent();
            	    writer.print(c);
            	    pos++;
            	} else {
            	    doIndent();
            	    writer.print("&#");
            	    writer.print(code);
            	    writer.print(";");
            	    pos += 3;
            	}
            break;
            }		
        }
    }
    /** Escape HTTP-special characters in s and
     * print the result.
     * @author andru
     * @param s the string to escape
     */
    public static String escape_URI(String s) {
        StringWriter w = new StringWriter();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
            case '"': w.write("%22"); break; // otherwise, messes up HTML			
            case ' ': w.write("%20"); break; // may help pasting
            case '%': w.write("%25"); break;
            default:
                int code = (int)c;
            if (code >= 0x21 && code <= 0x7E) {
                w.write(c);		    
            } else {
                // technically, codes 00-1f are not allowed in a URI, but they
                // are escaped here anyway.
                w.write("%");
                w.write((int)hex[c / 16]);
                w.write((int)hex[c % 16]);
            }
            break;
            }		
        }
        return w.toString();	
    }
    
    String currentClass() {
        return currentClass;
    }
    /**
     * @param class_
     */
    void setClass(String class_) {
        currentClass = class_;
    }
}
