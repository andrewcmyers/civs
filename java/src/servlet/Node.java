package servlet;

import java.io.PrintWriter;

public abstract class Node {
    abstract void write(PrintWriter p, int indent);
}
