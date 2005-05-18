package civs;

import javax.servlet.ServletException;

import servlet.*;

/** The Vote action starts the voting process.
 * 
 * @author andru
 *
 */
public class Vote extends CIVSAction {
    
    Vote(Main main) {
        super("vote", main);
    }
    
    /* (non-Javadoc)
     * @see servlet.Action#invoke(servlet.Request)
     */
    public Page invoke(Request req) throws ServletException {
        String eid = req.getParam(main.election_id);
        Election election = main.findElection(eid);
        if (election == null) {
            return main.reportError(req, "Illegal input", "Illegal Input",
              "Election not found, bad election id: " + eid);
        }

        Name voter_key;
        
        int n = election.choices.length;
        Node[] rows_arr = new Node[n];        
        Option[] options = new Option[n+1];
        Select[] selects = new Select[n];
        for (int i = 0; i < n; i++) {
            options[i] = new Option("" + (i+1));
            selects[i] = new Select(main, n-1, options);
        }
        options[n] = new Option("No opinion");
        
        int[] permute = Misc.randomPermutation(n);
        // XXX Can we view permute as being computed by the Chaum tellers? How to 
        // XXX pass through to the client?

        Action castVote;        


        if (election.open_poll) {
            String auth_key = req.getParam(main.auth_key);
            if (!election.auth_key_hash.equals(new Nonce().md5(auth_key))) {
                return main.reportError(req, "Invalid authorization key", "Invalid Authorization Key",
                        "The authorization key " + auth_key + " is incorrect, voting not allowed."); 
            }
            voter_key = openVoterKey(req, main, auth_key); 
            castVote = new CastVote(main, selects, election, auth_key);
        } else {
            voter_key = closedVoterKey(req, main);
            if (!election.isAuthorized(voter_key)) {
                return main.reportError(req, "Invalid voter key",
                        "Invalid Voter Key",
                        "The voter key " + voter_key.toHex() + " is not authorized to vote in this election.");
            }
            castVote = new CastVote(main, selects, election, voter_key);
        }
        
        boolean revote = election.voterKeyUsed(voter_key);
        if (revote && !election.allow_revotes) {
            return main.reportError(req, "Voter key already used",
                    "Revote attemped denied",
                    "The voter key " + voter_key.toHex() + " has already been used" +
                    " in this election.");
        } 

                    
        for (int i = 0; i < n; i++) {            
            rows_arr[i] = new TRow(new NodeList(
              new NodeList(
                new TCell(new Text(election.choices[permute[i]])),
                new TCell(selects[permute[i]]))));
        }
        NodeList rows = new NodeList(rows_arr);
  	
        return main.createPage("CIVS: Vote on " + election.title,
          new NodeList(main.banner((revote ? "Vote: " : "Revote:")+ election.title, req),
             new Div("contents", new NodeList(new Node[] {
                  new Paragraph(new Text(election.description)),
                  new Paragraph(new NodeList(new Text(
                    "Cast your vote by giving each of the following choices a rank, " +
                    "where a smaller-numbered rank means that you prefer that choice more. " +
                    "For example, it would make sense to give your top choice (or choices) the rank 1." +
                    " You may give choices the same rank if you have no preference between them. " +
                    "You do not have to use all the possible ranks. " +
                    "All choices are initially given the lowest possible rank. "),
                    new Span("emph", new Text("Note: ")),
                    new Text("\"No opinion\" is not the same as the lowest possible rank; " +
                            "it genuinely expresses no opinion."))),
                  new Paragraph(new NodeList(
                          new Text("The election supervisor is "),
                          new Span("emph", election.name),
                          new Text(". Contact the election supervisor at "),
                          new Span("emailAddr", election.email),
                          new Text(" if assistance is needed."))),
                          
                    new Div("ballot",
                       main.createForm(castVote, req,
                          new NodeList(                            
                            new Table("ballot",
                              new TRow(new NodeList(
                                 new TCell("choice", new Text("Choice"), 1, true),
                                 new TCell("rank", new Text("Rank"), 1, true)))
                               .setClass("ballot"),
                              rows).setCellSpacing(0).setId("ballot"), 
                            new SubmitButton(main, "Cast vote"))
             ))}))), "vote.js");
    }    
    
    static Name openVoterKey(Request req, Main main, String auth_key)
    	throws ServletException {
            Nonce n = new Nonce();
            n.md5(req.remoteAddr());
            n.md5(auth_key);
            return n.md5(main.getPrivateHostID());
    }
    static Name closedVoterKey(Request req, Main main) {
            String voter_key_s = req.getParam(main.voter_key);
            return voter_key_s != null ? new Name(voter_key_s) : null;
    }
}

class CastVote extends CIVSAction {
    Select[] ballot;
    Election election;
    String auth_key;
    Name voter_key;

    /**
     * @param main_
     */
    CastVote(Main main_, Select[] ballot_, Election election_, String a) {
        super(main_);
        ballot = ballot_;
        election = election_;
        auth_key = a;        
    }

    /**
     * @param main
     * @param selects
     * @param election_
     * @param voter_key
     */
    public CastVote(Main main, Select[] selects, Election election_, Name v) {
        super(main);
        ballot = selects;
        election = election_;
        voter_key = v;
    }

    /* (non-Javadoc)
     * @see servlet.Action#invoke(servlet.Request)
     */
    public Page invoke(Request req) throws ServletException {
        String voter_key_s;
        Name voter_key;
        if (election.open_poll) {
            voter_key = Vote.openVoterKey(req, main, auth_key);                
        } else {
            voter_key = Vote.closedVoterKey(req, main);
            if (!election.isAuthorized(voter_key))
                return main.reportError(req,
                        "CIVS: Invalid voter key",
                        "Invalid Voter Key",
                        "The voter key presented is not authorized to vote in this election.");
        }
        String receipt = main.generateNonce();
        Nonce n2 = new Nonce();
        n2.md5(receipt);
        Name ballot_key = n2.md5(main.getPrivateHostID());
        
        Rank[] ranks = new Rank[ballot.length];
        for (int i = 0; i < ballot.length; i++) {
            String rank = req.getParam(ballot[i]);
            ranks[i] = Rank.parseRank(rank);
        }
        Ballot b = new Ballot(ballot_key, ranks);
        
        boolean revote = election.voterKeyUsed(voter_key);
        
        election.castBallot(voter_key, b, main);
        
        Node[] results = new Node[ballot.length];
        for (int i = 0; i < ballot.length; i++) {
            results[i] = new Paragraph(new Text(election.choices[i] + ": " +
                    req.getParam(ballot[i])));
        }
        return main.createPage("CIVS: Voting receipt",
             new NodeList(
                main.banner("Voting receipt", req),
                new Div("contents", new NodeList(
                new Paragraph(new NodeList(
                        new Text("Thank you for casting your vote.\n"),
                        revote ? 
                            new Text("This ballot supersedes the ballot " +
                                     " you cast earlier.\n")
                        :
                            new Text("You may update your ballot at any time until" +
                        		" the election ends.\n"),
                        new Text("Your digital receipt is\n"),
                        new Span("code",
                                election.id + "/" +
                                voter_key.toHex() + "/" +
                                receipt),
                        new Text("."))),
                new NodeList(results)))));
    }
}
