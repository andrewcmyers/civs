package civs;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;

import servlet.*;

/**
 * @author andru
 *
 * A session for the supervisor to control the election.
 */
public class ControlElection extends CIVSAction {
    
    ControlElection(Main main) { super("control", main); }
    
    final InputNode voters_inp = new TextArea(main, 5, 60, "");
    final InputNode voters_upload = new FileChooser(main);
    
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
        
        return electionReport(election, req);
    }
    
    Page electionReport(Election election, Request req) throws ServletException {
        String status;
        
        if (election.isStopped()) {
            status = "Ended " + election.actual_end + " (was announced to end " +
            election.ends + ").";
        } else {
            status = "In progress. Announced to end " + election.ends + ".";
        }
        NodeList choicesNode = new NodeList(new Text(election.choices[0]));
        for (int i = 1; i < election.choices.length; i++) {
            choicesNode = choicesNode.append(new Text(", " + election.choices[i]));
        }
        
        NodeList tableEntries =
            new NodeList(new Node[]{
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
                                            new Text(" (" + election.name + ")"))))),
                    new TRow(new NodeList(
                            new TCell("desc", new Text("Description:"), 1, false),
                            new TCell(new Text(election.description)))),
                    new TRow(new NodeList(
                            new TCell("desc", new Text("Choices:"), 1, false),
                            new TCell(new Span("choicesList", choicesNode))))
            });
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
        String auth_key = req.getParam(main.auth_key);
        if (election.open_poll) {
            Map args = new HashMap();
            args.put(main.auth_key, auth_key);
            args.put(main.election_id, election.id);
            String voteURL = main.createRequestURL(main.vote, args, req);
            tableEntries = tableEntries.append(new TRow(new NodeList(
                    new TCell("desc", new Text("Open poll:"), 1, false),
                    new TCell(new NodeList(new Text("Direct voters to "),
                            new Span("URL",
                            main.createRequest(main.vote, args, req, new Text(voteURL)))))
            )));
        } else {
            tableEntries = tableEntries.append(new TRow(new NodeList(
                    new TCell("desc", new Text("Authorized voters:"), 1, false),
                    new TCell(new Text("" + election.numAuthVoters())))));
        }
        
        tableEntries = tableEntries.append(new TRow(new NodeList(
                new TCell("desc", new Text("Options:"), 1, false),
                new TCell(new Text(options)))));
        
        return main.createPage("CIVS: Election Control",
          new NodeList(
            main.banner("Election Control: " + election.title, req),
            new Table("electionControl", null, tableEntries),
            (!election.isStopped()) ?
              new NodeList(
                      main.createForm(
                        new StopElection(main, election),
                        req, new NodeList(
                          new Hidden(main.auth_key, auth_key),
                          new SubmitButton(main, "End election"))),							
                          main.createForm(
                            new AddVoters(main, election),
                            req,
                                new NodeList(
                                  voters_inp, new Br(),
                                  new Span("tiny",
                                          new Text("Enter one voter e-mail address per line " +
                                                   " or upload addresses from a file.")),
                                  new Br(),
                                  new NodeList(
                                    voters_upload,
                                    new Br(),
                                    new SubmitButton(main, "Add voters")))))
                                : (Node)new Text("")));
    }
    class StopElection extends CIVSAction {
        Election election;
        
        StopElection(Main main, Election e) {
            super(main);
            election = e;
        }
        /* (non-Javadoc)
         * @see servlet.Action#invoke(servlet.Request)
         */
        public Page invoke(Request req) throws ServletException {
            election.stop(main);
            return electionReport(election, req);
        }
    }
    class AddVoters extends CIVSAction {
        Election election;
        AddVoters(Main main, Election e) {
            super(main);
            election = e;
        }
        /* (non-Javadoc)
         * @see servlet.Action#invoke(servlet.Request)
         */
        public Page invoke(Request req) throws ServletException {
            // TODO Auto-generated method stub
            String s1 = req.getParam(voters_inp);
            String s2 = req.getParam(voters_upload);
            String auth_key = req.getParam(main.auth_key);
            String[] voters1 = s1.split("[\r\n][\r\n]*");

            Vector voters2 = new Vector();
            
            for (int i = 0; i < voters1.length; i++) {
                if (Misc.isValidEmail(voters1[i]))
                    voters2.add(voters1[i]);
            }
            
            String uploaded = req.getParam(voters_upload);
            if (uploaded != null) {
                voters1 = uploaded.split("[\r\n][\r\n]*");
                for (int i = 0; i < voters1.length; i++) {
                    if (Misc.isValidEmail(voters1[i]) &&
                            !voters2.contains(voters1[i])) {
                        voters2.add(voters1[i]);
                    }
                }			
            }
            Map m = election.addVoters(auth_key, voters2, main);
            return null;
        }
    }
    
}
