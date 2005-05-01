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
        p.print("<input");
        p.begin();
        p.print(" type=text");
        p.print(" name=");
        p.printq(input.getName());
        p.print(" size=");
        p.printq(size);
        p.print(" value=");
        p.printq(initial_text);
        p.end();
        p.print(" />");
    }
}
