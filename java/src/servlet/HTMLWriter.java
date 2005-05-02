package servlet;

import java.util.Stack;
import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * @author andru
 * 
 * A class for generating indented output. Has begin() and end() to indicate
 * structure. Does not try to optimize line breaking or anything fancy.
 * XXX Currently inserts whitespace in places where it shouldn't.
 */
public class HTMLWriter {
    int indent = 0;
    boolean noindent = false;
    String currentClass = null;
    int pos = 0;
    Stack s = new Stack();
    
    PrintWriter writer;
    
    public HTMLWriter(PrintWriter p) {
        writer = p;
    }
    public void print(String s) {
        pos += s.length();
        writer.print(s);
    }
    public void print(int i) {
        print(Integer.toString(i));
    }
    /* Output s with quotes around it. */
    public void printq(String s) {
        print("\"");
        escape(s);
        print("\"");
    }
    public void printq(int i) {
        printq(Integer.toString(i));
    }
    public void breakLine() {
        writer.print("\r\n");
        if (!noindent) {
            for (int i = 0; i < indent; i++) {
                writer.print(" ");
            }
        }
        pos = indent;
    }
    public void indent(int n) {
        indent += n;
    }
    
    public void begin() {
        s.push(new Integer(indent));
        indent = pos;
    }
    
    public void end() {
        indent = ((Integer)s.pop()).intValue();
    }
    
    public void noindent(boolean b) {
        noindent = b;
    }
    
    public void close() {
        writer.close();
    }
    
    /** Escape HTML special characters in s and
     * print the result. */
    
    static char[] hex = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    public void escape(String s) {
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
            default:
                int code = (int)c;
            if (code >= 0x20 && code <= 0x7E) {
                writer.print(c);
                pos++;				    
            } else {
                writer.print("&#");
                writer.print(code);
                writer.print(";");
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
