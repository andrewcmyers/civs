package servlet;

/**
 * A "file" input that allows the client to upload the contents of a file.
 * 
 * @author andru
 *
 */
public class FileChooser extends InputNode {
    
    public FileChooser(Servlet s) {
        super(new Input(s));
    }
    /* (non-Javadoc)
     * @see servlet.Node#write(servlet.HTMLWriter)
     */
    public void write(HTMLWriter p) {
        p.print("<input type=file name=");
        p.printq(input.getName());
        p.print(" />");
    }
}
