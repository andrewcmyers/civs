package servlet;

public class Text extends Node {
    String contents;

    public Text(String s) { contents = s; }
    public void write(HTMLWriter w) { w.print(contents); }
}
