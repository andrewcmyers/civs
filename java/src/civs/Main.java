package civs;

import java.io.File;
import java.io.IOException;
import servlet.*;

import javax.servlet.ServletException;

public final class Main extends Servlet {
	String hostID;
	String dataDir;
	
	public void initialize() {
		addSessionStart("create");
		addSessionStart("status");
		addSessionStart("vote");
		addSessionStart("control");
	}

	public Page get(Session session, Request request)
	  throws ServletException
	{
		String action = request.action();
		System.out.println("Action = " + action);
		if (action.equals("status")) {
			return doStatus();
		} else if (action.equals("create")) {
			return startCreate(session);
		} else if (action.equals("vote")) {
			// XXX parse some parameters here from user request.
			return startVote(session); // XXX should have some parameters here.
		} else if (action.equals("control")) {
			// XXX parse some parameters here from user request.
			return doControl(session); // XXX pass some parameters here.
		}
		else return null;
	}
	
	public Page startVote(Session session) {
		return null;
	}
	
	public Page doControl(Session session) {
		return null;
	}
	
	public Page doStatus() {
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
	
	public Node banner() {
		return new Header(1, "Condorcet Internet Voting Service");
		// XXX Need tables for this.		
	}
	
	public Page startCreate(Session session) {		
		return createPage("CIVS Election Creation",
		  new NodeList(banner(),
		      new Header(2, "Create Election"),
			  new Paragraph(new Text("This web page allows you to create a new " +
			  		"web election. You will be the supervisor of " +
			  		"the election you create.")),
					createForm("finish_create",
							new NodeList(
							   new NodeList(
									new Text("Name of the election:"),
									new TextInput("title", 50, ""),
									new Br()),
							   new NodeList(
									new Text("Your name:"),
									new TextInput("name", 20, ""),
									new Br()),
							   new NodeList(
							   		new Text("Your email address:"),
									new TextInput("email_addr", 20, ""),
									new Br()),						   		
							   new NodeList(new Text("Day and time you plan to stop the election"),
							   		        new TextInput("election_end", 20, "tomorrow at 5pm"),
										    new Br())
												
							), session)));						
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
