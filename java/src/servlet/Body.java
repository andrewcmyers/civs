package servlet;

public class Body extends BlockContainer {
    Node contents;	
    public Body(Node contents) {
        super("body", contents);
    }
}
