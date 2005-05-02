package servlet;

/** A Node represents part of an HTML document.
 *  It can be written out to an HTMLWriter in a
 *  somewhat pretty-printed style.
 **/
public abstract class Node {    
    /** Write out HTML for this node to p. */
    public abstract void write(HTMLWriter p);
}
