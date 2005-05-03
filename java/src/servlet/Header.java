package servlet;

public class Header extends BlockContainer {
    int level;
    
    public Header(int level, Node contents) {
        super("h"+level, contents);
        if (level < 1 || level > 5) {
            throw new IllegalArgumentException();
        }
        this.level = level;
    }
    
    /**
     * @param i
     * @param header
     */
    public Header(int i, String header) {
        this(i, new Text(header));
    }
}
