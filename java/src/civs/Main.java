package civs;

import java.io.File;
import java.io.IOException;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
	String hostID;
	String dataDir;
	
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
		public Page invoke(Request req) {
			int nr = concurrentRequests();
			Page p = createPage("CIVS Status",
					new NodeList(
							banner(),
							new Header(2, "CIVS Server Status"),
							new Paragraph(new Text("The CIVS server is up and\n" +
									"is now handling " + nr +
									(nr > 1 ? " concurrent requests."
											: " request (this one).")))));
			return p;
		}
	}

	public Node banner() {
		return new Header(1, "Condorcet Internet Voting Service");
		// XXX Need tables for this.		
	}
	

	
	/*	String q = request.expose().getQueryString();
		String url = request.expose().getRequestURI();
		String servletpath = request.expose().getServletPath();new Text("query string = " + q +
				"\nurl = " + url +
				"\nservletpath = " + servletpath +											
	 */
	
	public String dataDir() throws ServletException {
		if (dataDir == null) {
			dataDir = initParameter("CIVS_data_dir");
			if (dataDir == null ) {
				throw new ServletException("Can't determine where the CIVS data directory is.\r\n" +
						"Set the CIVS_data_dir parameter in the config file web.xml.");
			}
		}
		return dataDir;
	}
	
	public String getPrivateHostID() throws ServletException {
		String f = dataDir() + File.separatorChar +	"private_host_id";
		try {
			hostID = new String(Utils.fileContents(f));
		}
		catch (IOException exc) {
			throw new ServletException("cannot open private host ID file " + f);
		}
		return hostID;
	}
}
