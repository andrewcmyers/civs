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
        if (election.open_poll) {
            String auth_key = req.getParam(main.auth_key);
            if (!election.auth_key_hash.equals(Nonce.md5(auth_key))) {
                return main.reportError(req, "Invalid authorization key", "Invalid Authorization Key",
                        "The authorization key " + auth_key + " is incorrect, voting not allowed."); 
            }
        } else {
            String voter_key = req.getParam(main.voter_key);
            // TODO look up voter keys here.
        }
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
                    
        for (int i = 0; i < n; i++) {            
            rows_arr[i] = new TRow(new NodeList(
              new NodeList(
                new TCell(new Text(election.choices[permute[i]])),
                new TCell(selects[permute[i]]))));
        }
        NodeList rows = new NodeList(rows_arr);
  	
        return main.createPage("CIVS: Vote on " + election.title,
          new NodeList(main.banner("Vote: " + election.title, req),
                  new Paragraph(new Text(election.description)),
                  new Paragraph(new NodeList(
                     new Text("The election supervisor is "),
                     new Span("emph", election.name),
                     new Text(". Contact the election supervisor at "),
                     new Span("emailAddr", election.email),
                     new Text(" for assistance."))),
                  new Paragraph(new NodeList(new Text(
                    "Cast your vote by giving each of the following choices a rank, " +
                    "where a smaller-numbered rank means that you prefer that choice more. " +
                    "For example, it would make sense to give your top choice (or choices) the rank 1." +
                    " You may give choices the same rank if you have no preference between them. " +
                    "You do not have to use all the possible ranks. " +
                    "All choices are initially given the lowest possible rank. "),
                    new Span("emph", new Text("Note:")),
                    new Text("\"No opinion\" is not the same as the lowest possible rank; " +
                            "it genuinely expresses no opinion."))),
                    new Div("ballot",
                       main.createForm(new CastVote(main, selects, election), req,
                          new NodeList(                            
                            new Table("ballot",
                              new TRow(new NodeList(
                                 new TCell("choice", new Text("Choice"), 1, true),
                                 new TCell("rank", new Text("Rank"), 1, true)))
                               .setClass("ballot"),
                              rows).setCellSpacing(0), 
                            new SubmitButton(main, "Cast vote"))
                  ))));
    }
    
    class CastVote extends CIVSAction {
        Select[] ballot;
        Election election;

        /**
         * @param main_
         */
        CastVote(Main main_, Select[] ballot_, Election election_) {
            super(main_);
            ballot = ballot_;
            election = election_;
            
        }

        /* (non-Javadoc)
         * @see servlet.Action#invoke(servlet.Request)
         */
        public Page invoke(Request req) throws ServletException {
            // TODO 0. Determine/check voter key

            String voter_key_s;
            Name voter_key;
            if (election.open_poll) {
                voter_key_s = req.remoteAddr();
                voter_key = Nonce.md5(voter_key_s);
            } else {
                voter_key_s = req.getParam(main.voter_key);
                voter_key = voter_key_s != null ? new Name(voter_key_s) : null;
                if (!election.isAuthorized(voter_key))
                    return main.reportError(req,
                            "CIVS: Invalid voter key",
                            "Invalid Voter Key",
                            "The voter key presented is not authorized to vote in this election.");
            }
            Rank[] ranks = new Rank[ballot.length];
            for (int i = 0; i < ballot.length; i++) {
                String rank = req.getParam(ballot[i]);
                ranks[i] = Rank.parseRank(rank);
            }
            Ballot b = new Ballot();
            b.rankings = ranks;
            b.voter_key_hash = Nonce.md5(voter_key);
            // TODO check whether voter key has been used before
            // TODO 1. record vote by appending to log file.
            // TODO 2. compute voter receipt
            Node[] results = new Node[ballot.length];
            for (int i = 0; i < ballot.length; i++) {
                results[i] = new Paragraph(new Text(election.choices[i] + ": " +
                        req.getParam(ballot[i])));
            }
            return main.createPage("CIVS: Voting receipt", new NodeList(results));
        }
    }
    
    
}
