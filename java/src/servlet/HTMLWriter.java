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
	}

	public void breakLine() {
		writer.print("\n");
		for (int i = 0; i < indent; i++) {
			writer.print(" ");
		}
	}

	public void begin() {
		s.push(new Integer(indent));
		indent = pos;
	}

	public void end() {
		indent = ((Integer)s.pop()).intValue();
	}
}
