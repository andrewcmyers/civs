package servlet;

import java.util.Stack;
import java.io.PrintWriter;

/**
 * @author andru
 * 
 * A class for generating indented output. Has begin() and end() to indicate
 * structure. Does not try to optimize line breaking or anything fancy.
 */
public class HTMLWriter {
	int indent = 0;
	boolean noindent = false;
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
	 *
	 */
	public void HTTP_escape(String s) {
		writer.print(s);
		// XXX finish me		
	}
}
