package servlet;

/** An input that allows typing in a password. */
public class PasswordInput extends TextInput {
    public PasswordInput(Servlet s, int size, String initial) {
        super(s, size, initial);
    }
    public void write(HTMLWriter p) {
        p.print("<input");
        p.begin();
        p.print(" type=\"password\"");
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
