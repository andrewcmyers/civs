package civs;

import java.io.File;
import java.io.IOException;
import servlet.*;
import javax.servlet.ServletException;

public final class Main extends Servlet {
	String hostID;
	String dataDir;
	
	public Main() {
		
	}
	
	public Page get(Request request) throws ServletException {
		Session session = request.session();
		String action = request.action();
		if (session == null) {
			// XXX check whether this is an acceptable way to start session
			session = new Session(this);
		}

		Page p = new Page(new Head("CIVS Test page"),
			            new Body(
			            	new NodeList(
			            		new Header(1, "A Test Servlet"),
								new NodeList(
			            		  new Paragraph(new Text("This is some text.\n" +
			            		  		"It is very nice text.\n" +
										"The servlet is now handling " +
										concurrentRequests() +
			            		  		" concurrent requests.")),
								  new Pre(new Text("action = " +
										request.expose().getParameter("action")))		
			            	)	)));
		return p;
	}
	/*	String q = request.expose().getQueryString();
		String url = request.expose().getRequestURI();
		String servletpath = request.expose().getServletPath();new Text("query string = " + q +
				"\nurl = " + url +
				"\nservletpath = " + servletpath +											
	 */
	
	public String dataDir() throws ServletException {
		if (dataDir == null) {
			dataDir = initParameter("CIVSDATADIR");
			if (dataDir == null ) {
				throw new ServletException("Can't determine where the CIVS data directory is.\r\n" +
						"Set CIVSDATADIR in the config file.");
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
