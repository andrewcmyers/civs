/*
 * Created on Mar 8, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
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
	public void printq(String s) {
		print("\"");
		print(s);
		print("\"");
	}
	public void printq(int i) {
		printq(Integer.toString(i));
	}
	public void breakLine() {
		writer.print("\r\n");
		for (int i = 0; i < indent; i++) {
			writer.print(" ");
		}
		pos = indent;
	}

	public void begin() {
		s.push(new Integer(indent));
		indent = pos;
	}

	public void end() {
		indent = ((Integer)s.pop()).intValue();
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
			    case '\r':
				case '\n':
					writer.print("\r\n");
					if (i+1 < s.length() &&
							(int) c + (int) s.charAt(i+1) == 23)
						i++;
					breakLine();					
					break;
				default:
					int code = (int)c;
				    if (code >= 0x20 && code <= 0x7E || code >= 0xA0 && code <= 0xFF) {
				    	writer.print(c);
				    	pos++;				    
				    } else {
				    	writer.print("&#");
				    	writer.print(code);
				    }
				    break;
			}		
		}	
	}
}
