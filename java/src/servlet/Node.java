package servlet;

/** A Node represents part of an HTML document.
 *  It can be written out to an HTMLWriter in a
 *  somewhat pretty-printed style.
 *  */
public abstract class Node {
    
    /** Write out HTML for this node to p. */
    public abstract void write(HTMLWriter p);
    
    /** Modify the current node to have HTML class c and
     * return the node.
     * @param c the new class
     * @return
     */
    
}
