package servlet;

/** An input that allows typing in a single line of text. Appropriate
 * for most textual input. */
public class TextInput extends InputNode {
    int size;
    String initial_text;
    public TextInput(Servlet s, int size, String initial) {
        super(new Input(s));
        this.size = size;
        initial_text = initial;
    }
    public void write(HTMLWriter p) {
        p.begin(2);
        p.print("<input");
        p.allowBreak(0, 2, " ");
        p.begin();
        p.print("type=text");
        p.unifiedBreak();
        p.print("name=");
        p.printq(input.getName());
        p.unifiedBreak();
        p.print("size=");
        p.printq(size);
        p.unifiedBreak();
        p.print("value=");
        p.printq(initial_text);
        p.end();
        p.allowBreak(-2, 2, "");
        p.end();
        p.print("/>");
    }
}
