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

	Map elections = new HashMap(); // map from id -> Election
	
	public void initialize() {
		addStartAction("create",  new CreateElection(this));
		addStartAction("status",  new DoStatus(this));
		addStartAction("vote",    new Vote(this));
		addStartAction("control", new ControlElection(this));
		addStartAction("results", new ShowResults(this));
	}
	
	// Should we create a new session for every request, or
	// reuse the old session? One big issue is how to deal with
	// requests from old forms (which may even be concurrent
	// with new requests).
	
	class DoStatus extends Action {
		public DoStatus(Servlet s) {
			super(s);
			// TODO Auto-generated constructor stub
		}
		public Page invoke(Request req) throws ServletException {
			int nr = concurrentRequests();
			Page p = createPage("CIVS Status",
					new NodeList(
							banner("CIVS Status"),
							new Paragraph(new Text("The CIVS server is up and\n" +
									"is now handling " + nr +
									(nr > 1 ? " concurrent requests."
											: " request (this one).")))));
			return p;
		}
	}

	public Node banner(String title) throws ServletException {
		return new Table("banner", null, new NodeList(new TRow(new NodeList(
				new TCell("bannertop", new Header(1,
						"Condorcet Internet Voting Service"), 1, false),
				new TCell("bannerright", new NodeList(new Hyperlink(civs_url(),
						new Text("CIVS Home")), new Br(), new Hyperlink(
						servlet_url() + "?request=create", new Text(
								"Create new election")), new Br(),
						new Hyperlink(civs_url() + "/sec_priv.html", new Text(
								"About security and privacy"))), 1, false))),
				new TRow(new TCell("bannerbottom", new Header(2, title), 2,
						false))));
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
	
	String servlet_url() throws ServletException {
		return servletParam("servlet_url", "the CIVS servlet url.");
	}
	
	String servlet_host() throws ServletException {
		return servletParam("servlet_host", "the CIVS servlet host");
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

	/** Find the election with id <code>id</code> and return it. Read from the data directory
	 *  if this election is not yet in memory. Return null if no such election exists. 
	 * @param id
	 * @return the named election
	 * @throws ServletException
	 * @throws IOException
	 */
	public Election findElection(String id) throws ServletException {
		try {
			Election e = (Election) elections.get(id);
			if (e != null) return e;
			String filename = dataDir() + File.separatorChar + "elections" +
								File.separatorChar + id;
			FileInputStream f = new FileInputStream(new File(filename));
			ObjectInputStream of = new ObjectInputStream(f);	
			e = (Election) of.readObject();
			of.close();
			f.close();
			return e;
		}
			catch (ClassNotFoundException exc) { return null; }
			catch (IOException exc) {return null;}
	}
	
	public void saveElection(Election e) throws ServletException {
		try {
			String filename = dataDir() + File.separatorChar + "elections" +
			File.separatorChar + e.id;
			FileOutputStream f = new FileOutputStream(filename, true);
			ObjectOutputStream of = new ObjectOutputStream(f);
			of.writeObject(e);
			of.close();
			f.close();
			return;
		} catch (FileNotFoundException exc) {
			throw new ServletException("Cannot save election " + e.id + " (no output file)");
		} catch (IOException exc) {
			throw new ServletException("Cannot save election " + e.id + " (no object stream)");
		}
	}
}
