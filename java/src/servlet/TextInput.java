/*
 * Created on Mar 14, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package servlet;

/**
 * @author andru
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TextInput extends Input {
	int size;
	String initial_text;
    public TextInput(String name, int size, String initial) {
    	super(name);
    	this.size = size;
    	initial_text = initial;
    }
	public void write(HTMLWriter p) {
		p.print("<input");
		p.begin();
		p.print(" type=text ");
		p.print(" name=");
		p.printq(getName());
		p.print(" size=");
		p.printq(size);
		p.print(" value=");
		p.printq(initial_text);
		p.end();
		p.print(">");
	}
}
