package civs;

import java.io.File;
import java.io.IOException;
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
		return new Table("banner", null, 
				new NodeList(
					new TRow(new NodeList(
							new TCell("bannertop",
									new Header(1, "Condorcet Internet Voting Service"), 1, false),
							new TCell("bannerright",
									new NodeList(
											new Hyperlink(home(), new Text("CIVS Home")),
											new Br(),
											new Hyperlink(servlet_url() +
													"?request=create", new Text("Create new election")),
											new Br(),
											new Hyperlink(home() + "/sec_priv.html",
													new Text("About security and privacy"))),
													1, false
					))),
					new TRow(new TCell("bannerbottom",
							new Header(2, title), 2, false))
				));
	}
								/*			
		<table class="banner" border="0" width="100%" cellspacing="0" cellpadding="7">
		  <tbody><tr>
		    <td width="100%" valign="top" nowrap>

		      <h1>&nbsp;Condorcet Internet Voting
		      Service</h1>
		    </td>
		    <td width=0% nowrap valign=top align=right>
			<a href="/~andru/civs">CIVS Home</a><br>
			<a href="/~andru/civs/civs_create.html">Create new election</a><br>
			<a href="/~andru/civs/sec_priv.html">About security and privacy</a>
		    </td>

		  </tr>
		  <tr>
		    <td width="100%" valign="top" nowrap colspan=2>
		      <h2 align="center">Create a New Election</h2>
		    </td>
		  </tr>
		</tbody>
		</table>
		*/
	
	/*	String q = request.expose().getQueryString();
		String url = request.expose().getRequestURI();
		String servletpath = request.expose().getServletPath();new Text("query string = " + q +
				"\nurl = " + url +
				"\nservletpath = " + servletpath +											
	 */
	
	String servlet_url;
	private String servlet_url() throws ServletException {
		if (servlet_url == null) {
			servlet_url = initParameter("servlet_url");
			if (servlet_url == null) {
				throw new ServletException("Can't determine the CIVS servlet url.\r\n" +
						"Set the servlet_url parameter in the config file web.xml.");
			}
		}
		return servlet_url;
	}
	String dataDir;
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
	String CIVS_home;
	public String home() throws ServletException {
		if (CIVS_home == null) {
			CIVS_home = initParameter("CIVS_home");
			if (CIVS_home == null ) {
				throw new ServletException("Can't determine where the CIVS home url is.\r\n" +
						"Set the CIVS_home parameter in the config file web.xml.");
			}
		}
		return CIVS_home;
	}
	
	public String supervisor() {
		return initParameter("supervisor");
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
