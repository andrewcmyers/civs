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
			return main.reportError(req, "Illegal input", "Illegal Input", "Election not found, bad election id: " + election_id);
		}
		
		if (!election.auth_key_hash.equals(Nonce.md5(auth_key))) {
			return main.reportError(req, "Invalid authorization key", "Invalid Authorization Key",
					"The authorization key " + auth_key + " is incorrect."); 
		}
		if (!election.control_key_hash.equals(Nonce.md5(control_key))) {
			return main.reportError(req, "Invalid control key", "Invalid Control Key",
					"The control key " + control_key + " is incorrect.");
		}
		String status;

		if (election.stopped) {
			status = "Ended " + election.actual_end + " (was announced to end " +
			   election.ends + ").";
		} else {
			status = "In progress. Announced to end " + election.ends + ".";
		}
		NodeList choicesNode = new NodeList(new Text(election.choices[0]));
		for (int i = 1; i < election.choices.length; i++) {
			choicesNode = choicesNode.append(new Br()).append(new Text(election.choices[i]));
		}
		
		NodeList tableEntries =
			new NodeList(
			  new TRow(new NodeList(
				new TCell("desc", new Text("Election title:"), 1, false),
				new TCell(new Text(election.title)))),
			  new TRow(new NodeList(
			  	new TCell("desc", new Text("Status:"), 1, false),
				new TCell(new Text(status)))),
			  new TRow(new NodeList(
			  	new TCell("desc", new Text("Supervisor:"), 1, false),
				new TCell(
					new NodeList(
						new Span("emailAddr", new Text(election.email)),
						new Text("(" + election.name + ")"))))),
			  new TRow(new NodeList(
			  	new TCell("desc", new Text("Description:"), 1, false),
				new TCell(new Text(election.description)))),
			  new TRow(new NodeList(
			  	new TCell("desc", new Text("Choices:"), 1, false),
				new TCell(new Span("choicesList", choicesNode))))
			);
		String options = "";
		
		if (election.allow_writeins) {
			options += "Write-ins allowed.";
		} else {
			options += "No write-ins allowed.";
		}
		if (election.allow_revotes) {
			options += " Revotes allowed.";
		}
		if (election.proportional) {
			options += " Proportional representation.";
		}
		if (election.shuffle) {
			options += " Ballot entries shuffled.";
		} else {
			options += " No ballot shuffling.";
		}

		tableEntries = tableEntries.append(new TRow(new NodeList(
				new TCell("desc", new Text("Options:"), 1, false),
				new TCell(new Text(options)))));
		
		return main.createPage("CIVS: Election Control",
				new NodeList(main.banner("Election Control: " + election.title, req),
						new Table("electionControl", null, tableEntries)));
	}
}
