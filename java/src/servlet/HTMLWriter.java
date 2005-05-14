package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * @author andru
 * 
 * A class for generating indented output. Has begin() and end() to indicate
 * structure. Does not try to optimize line breaking or anything fancy.
 */
public class HTMLWriter  {
    servlet.CodeWriter cw;
    boolean verbatim = false;
    String currentClass = null;
    int pos = 0;  // if pos == 0, the line is empty so far.
    public static final int MAX_WIDTH = 80;
    PrintWriter printWriter;
    
    public HTMLWriter(PrintWriter p) {
        printWriter = p;
        cw = new CodeWriter(p, MAX_WIDTH);
    }
    public void print(String s) {
        if (verbatim) {
            cw.write(s);
        } else {
            String t = "";
            for (int i = 0; i < s.length(); i++) {
                char c = s.charAt(i);
                if (Character.isWhitespace(c)) {
                    cw.write(t);
                    t = "";
                    cw.allowBreak(2);
                } else {
                    t += c;
                }
            }
            cw.write(t);
        }
    }
    public void allowBreak() {
        cw.allowBreak(2, 1, " ", 1);
    }
    public void allowBreak(int n, int level, String alt) {
        cw.allowBreak(n, level, alt, alt.length());
    }
    public void unifiedBreak() {
        cw.unifiedBreak(0, 1, " ", 1);
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
        cw.allowBreak(0);
    }
    
    public void begin() {
        cw.begin(0);
    }
    public void begin(int n) {
        cw.begin(n);
    }
    
    public void end() {
        cw.end();
    }
    
    public void noindent(boolean b) {
        verbatim = b;
    }
    
    public void close() throws IOException {
        boolean success = cw.flush();
        if (!success) printWriter.println("<!-- pretty-printing failed -->");
        else printWriter.println("<!-- pretty-printing succeeded -->");
        printWriter.flush();
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
            case ' ':
                if (verbatim || pos <= MAX_WIDTH - 8) {
                    cw.write(" ");
                    pos++;
                } else {
                    cw.allowBreak(2, 3, " ", 1);
                }
                break;
            case '\r':
            case '\n':
                cw.allowBreak(0, 1, " ", 1);
                while (i+1 < s.length() && (s.charAt(i+1) == '\r' ||
                        s.charAt(i+1) == '\n'))
                    i++;
                break;
            default:
                int code = (int)c;
            	if (code >= 0x21 && code <= 0x7E) {
            	    cw.write("" + c);
            	    pos++;
            	} else {
            	    cw.write("&#" + code + ";");
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
