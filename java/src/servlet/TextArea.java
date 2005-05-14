package servlet;

/**
 * @author andru
 *
 * A TextArea is a multi-line text input with a fixed
 * number of rows and columns.
 */
public class TextArea extends InputNode {
    int rows;
    int cols;
    String initial_text;
    
    public TextArea(Servlet s, int rows, int cols, String initial) {
        super(new Input(s));
        this.rows = rows;
        this.cols = cols;
        initial_text = initial;
    }
    public void write(HTMLWriter p) {
        p.print("<textarea");
        p.allowBreak(1, 2, " ");
        p.begin();
        p.print("name=");
        p.printq(input.getName());
        p.unifiedBreak();
        p.print("rows=");
        p.printq(rows);
        p.unifiedBreak();
        p.print("cols=");
        p.printq(cols);
        p.end();
        p.allowBreak(0, 2, " ");
        p.print(">");
        p.noindent(true);
        p.escape(initial_text);
        p.noindent(false);
        // what goes here in a textarea?
        p.print("</textarea>");
    }
}
