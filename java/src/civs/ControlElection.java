package civs;

import javax.servlet.ServletException;

import servlet.*;

/**
 * @author andru
 *
 * A session for the supervisor to control the election.
 */
public class ControlElection extends CIVSAction {

	ControlElection(Main main) { super(main); }
	public Page invoke(Request req) throws ServletException {
		// How to prevent creation of bogus input objects? They need to be tied to the servlet so that
		// only the servlet can use them?
		
		String election_id = req.getParam(main.election_id);
		String auth_key = req.getParam(main.auth_key);
		String control_key = req.getParam(main.ctrl_key);
		
		Election election = main.findElection(election_id);
		
		if (election == null) {
			return main.reportError("Illegal input", "Illegal Input", "Election not found, bad election id: " + election_id);
		}
		
		if (!election.auth_key_hash.equals(Nonce.md5(auth_key))) {
			return main.reportError("Invalid authorization key", "Invalid Authorization Key",
					"The authorization key " + auth_key + " is incorrect."); 
		}
		if (!election.control_key_hash.equals(Nonce.md5(control_key))) {
			return main.reportError("Invalid control key", "Invalid Control Key",
					"The control key " + control_key + " is incorrect.");
		}
		String status;

		if (election.stopped) {
			status = "Ended.";
		} else {
			status = "In progress.";
		}
		
		return main.createPage("CIVS: Election Control",
				
				new NodeList(main.banner("Election Control: " + election.title),
					new Table("electionControl", null,
						new NodeList(
						  new TRow(new NodeList(
							new TCell("desc", new Text("Election title:"), 1, true),
							new TCell(new Text(election.title)))),
						  new TRow(new NodeList(
						  	new TCell("desc", new Text("Status:"), 1, true),
							new TCell(new Text(status)))),
						  new TRow(new NodeList(
						  	new TCell("desc", new Text("Supervisor:"), 1, true),
							new TCell(
								new NodeList(
									new Span("emailAddr", new Text(election.email)),
									new Text("(" + election.name + ")"))))),
						  new TRow(new NodeList(
						  	new TCell("desc", new Text("Description:"), 1, true),
							new TCell(new Text(election.description)))))),
									
					new Text("This page is supposed to let you control an election."),
					new Pre(new Text("election id = " + election_id + "\r\n" +
							 "auth_key = " + auth_key + "\r\n" +
							 "control_key = " + control_key))
                ));
	}

}
