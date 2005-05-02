package civs;

import javax.servlet.ServletException;

import servlet.*;

/** The Vote action starts the voting process.
 * 
 * @author andru
 *
 */
public class Vote extends CIVSAction {
    
    CIVSAction castVote = new CastVote(main);
    
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
        for (int i = 0; i < n; i++) {
            options[i] = new Option("" + (i+1));
        }
        options[n] = new Option("No opinion");
            
        for (int i = 0; i < n; i++) {
            rows_arr[i] = new TRow(new NodeList(
              new NodeList(
                new TCell(new Text(election.choices[i])),
                new TCell(new Select(main, i, options)))));
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
                    main.createForm(castVote, req,
                          new NodeList(
                            new Table("ballot", null,
                              new NodeList(
                                new TRow(new NodeList(
                                  new TCell("choice", new Text("Choice"), 1, true),
                                  new TCell("rank", new Text("Rank"), 1, true))),
                                rows)),
                                 new SubmitButton(main, "Cast vote"))
                  )));
    }
    
    class CastVote extends CIVSAction {

        /**
         * @param main_
         */
        CastVote(Main main_) {
            super(main_);
            // TODO Auto-generated constructor stub
        }

        /* (non-Javadoc)
         * @see servlet.Action#invoke(servlet.Request)
         */
        public Page invoke(Request req) throws ServletException {
            // TODO Auto-generated method stub
            return null;
        }
    }
    
    
}
