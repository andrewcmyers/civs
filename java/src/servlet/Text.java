package servlet;

/** A Text is a simple sequence of text. */
public class Text extends Node {
    String contents;

    public Text(String s) { contents = s; }
    public void write(HTMLWriter w) { w.escape(contents); }
}
