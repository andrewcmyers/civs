package civs;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Map;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
    String hostID;
    
    // XXX do we need a mutex to synchronize accesses to "elections"?	
    Map elections = new HashMap(); // map from id -> Election
    Mutex elections_lock = new Mutex();
    
    final Input ctrl_key = new Input("ctrl", this);
    final Input auth_key = new Input("auth", this);
    final Input election_id = new Input("id", this);
    final Input voter_key = new Input("key", this);
    
    static final int MAX_LOAD = 50;
    
    CIVSAction controlElection, vote, showResults, status, create;
    
    public Main() throws ServletException {}
    
    public void initialize() {
        create = new CreateElection(this);
        controlElection = new ControlElection(this);
        vote = new Vote(this);
        showResults = new ShowResults(this);
        status = new DoStatus(this);
        
        addStartAction(status);
        addStartAction(create);
        addStartAction(vote);				// voter_key, election_id
        addStartAction(controlElection);     		// ctrl_key, auth_key, election_id
        addStartAction(showResults);				// election_id
        // XXX Do we need the inputs?        
    }
    
    public Node checkLoad(Request req) throws ServletException {
        if (concurrentRequests() > MAX_LOAD) {
            return reportError(req, "CIVS: Load too high", "Load too high",
                    "Sorry, there are more than " + MAX_LOAD +
                            "requests being handled now. Please try again later. " +
                            "If you have already retried, please wait about twice as" +
                            "long as the last time.");
        }
        return null;
    }
    
    // Should we create a new session for every request, or
    // reuse the old session? One big issue is how to deal with
    // requests from old forms (which may even be concurrent
    // with new requests).
    
    class DoStatus extends CIVSAction {
        public DoStatus(Main s) { super("status", s); }
        public Page invoke(Request req) throws ServletException {
            int nr = concurrentRequests();
            return createPage("CIVS Status",
                    new NodeList(
                        banner("CIVS Status", req),
                        new Div("contents",
                            new Paragraph(new Text("The CIVS server is up and\n" +
                                    "is now handling " + nr +
                                    (nr > 1 ? " concurrent requests."
                                            : " request (this one)."))))));
        }
    }
    
    public Node banner(String title, Request req) throws ServletException {
        return new Div("banner", new Table("banner", null, new NodeList(new TRow(new NodeList(
                new TCell("bannertop", new Header(1,
                "Condorcet Internet Voting Service"), 1, false),
                new TCell("bannerright", new NodeList(new Node[] {
                        new Hyperlink(civs_url(), new NodeList(
                          new Text("CIVS"), new NBSP(), new Text("Home"))),
                        new Br(),
                        createRequest(create, null, req,
                                new Text("Create new election")), new Br(),
                        new Hyperlink(civs_url() + "/sec_priv.html", new NodeList(
                                new Text("About"), new NBSP(),
                                new Text("security"), new NBSP(),
                                new Text("and"), new NBSP(),
                                new Text("privacy")))}), 1, false))),
                        new TRow(new TCell("bannerbottom", new Header(2, title), 2,
                                false)))));
    }
    
    public Page reportError(Request req, String title, String header, String message) throws ServletException {
        return createPage("CIVS: " + title, new NodeList(banner(header, req),
                new Paragraph(new Span("errormsg", new Text(message)))));
    }
    
    Map servletParams = new HashMap();
    String servletParam(String name, String what) throws ServletException {
        if (servletParams.containsKey(name)) {
            return (String)servletParams.get(name);			
        }
        String s = initParameter(name);
        if (s == null) {
            throw new ServletException("Can't determine " + what + ". Set the " + name +
            "parameter in the configuration file web.xml.");
        } else {
            servletParams.put(name, s);
            return s;
        }		
    }
    
    public String servlet_url() throws ServletException {
        return servletParam("servlet_url", "the CIVS servlet url.");
    }
    
    public String dataDir() throws ServletException {
        return servletParam("CIVS_data_dir", "CIVS data directory");
    }
    public String civs_url() throws ServletException {
        return servletParam("CIVS_url", "the CIVS home URL");
    }
    
    public String supervisor() throws ServletException {
        return servletParam("supervisor", "the supervisor e-mail address");
    }
    
    /** A global way to name the CIVS home. */
    public String civs_host() throws ServletException {
        return servletParam("CIVS_host", "the CIVS host");		
    }
    
    private String local_debug;
    boolean local_debug() throws ServletException {
        String local_debug = servletParam("local_debug", "whether local debugging is turned on");
        return local_debug.equals("1");
    }
    
    public String getPrivateHostID() throws ServletException {
        String f = dataDir() + File.separatorChar + "private_host_id";
        try {
            hostID = new String(Utils.fileContents(f));
        } catch (IOException exc) {
            throw new ServletException("cannot open private host ID file " + f);
        }
        return hostID;
    }
    /* (non-Javadoc)
     * @see servlet.Servlet#external_servlet_url()
     */
    
    public void saveElection(Election e, boolean create) throws ServletException {
        try {
            String dirname =  dataDir() + File.separatorChar + "elections" +
            File.separatorChar + e.id;
            if (create && !new File(dirname).mkdir()) {
                throw new ServletException("Election already exists: " + e.id);
            }
            String filename = dirname + File.separatorChar + "election";
            FileOutputStream f = new FileOutputStream(filename, false);
            ObjectOutputStream of = new ObjectOutputStream(f);
            of.writeObject(e);
            of.close();
            f.close();
            return;
        } catch (FileNotFoundException exc) {
            throw new ServletException("Cannot save election " + e.id + " (no output file)");
        } catch (IOException exc) {
            throw new ServletException("Cannot save election " + e.id + " (I/O exception)" + exc);
        }
    }
    
    /** Find the election with id <code>id</code> and return it. Read from the data directory
     *  if this election is not yet in memory. Return null if no such election exists. 
     * @param id
     * @return the named election
     * @throws ServletException
     * @throws IOException
     */
    
    public Election findElection(String id) throws ServletException {
        String dirname = dataDir() + File.separatorChar + "elections" + File.separatorChar + id;
        String filename = dirname + File.separatorChar + "election";
        
        try {
            Election e;
            synchronized (elections) {
                e = (Election) elections.get(id);
                // we don't try to lock down elections during the whole file read...
                // it's possible for multiple threads to be trying to read the same
                // elections file.
            } 
            
            if (e != null) return e;
            ObjectInputStream of;
            FileInputStream f;
            try {
              of = new ObjectInputStream(f =new FileInputStream(
                      new File(filename)));
            } catch (IOException exc) {
                throw new ServletException("Can't open election file " + filename, exc);
            }
            try {
                e = (Election) of.readObject();
            } catch (IOException exc) {
                throw new ServletException("Bad election serialization. Version problems?", exc);
            }
            //of.close();
            //f.close();
            
            e.readBallots(dataDir());
            
            synchronized (elections) {
                Election e2 = (Election) elections.get(id);
                if (e2 != null) {
                    // we had a race. Just return the one that was already read.
                    return e2;
                }
                elections.put(id, e);
                return e;
            }
        }
        catch (ClassNotFoundException exc) { throw new ServletException("Class not found", exc);} 
        //catch (IOException exc) { throw new ServletException("I/O exception reading election from " + filename, exc); }
    }
}
