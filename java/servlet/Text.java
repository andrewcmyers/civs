package servlet;

import java.io.PrintWriter;

public class Text extends Node {
    String contents;

    Text(String s) { contents = s; }
    void write(PrintWriter p, int indent) { p.print(s); }
}
