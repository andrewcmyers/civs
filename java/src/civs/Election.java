package civs;

import java.io.File;import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.BufferedReader;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;


import javax.servlet.ServletException;

import servlet.Name;
import servlet.Nonce;


/**
 * An Election contains the information describing an election. It
 * is serialized to a file. It is not modified by voter actions, only
 * by the supervisor. Locking is provided by the servlet, not through the
 * file system.
 * 
 * All election data is stored in CIVS_DATA_DIR/elections/id/
 */
public class Election implements Serializable {
    String id;

    //	(Mostly) fixed properties of the election.
    String title; // election title
    String name;  // name of the election supervisor
    String email; // supervisor email
    String description; // description of the election
    String ends; // description of when the election ends.
    String actual_end; // when the election actually ended.
    
    String[] choices;
    Name auth_key_hash;
    Name control_key_hash;
    boolean proportional;
    boolean allow_writeins;
    boolean allow_revotes;
    int num_winners;
    public boolean shuffle;
    public boolean report_ballots;
    public boolean open_poll;
    
    // The following fields are private to guard against races.
    // synchronized methods of Election must be used to access them.
    
    private boolean started = false;
    private boolean stopped = false;
    
    private Collection authorized_voters = new HashSet();
    // Hashes (Names) of the voter identities (email addrs) that have been authorized to vote.
    // Used to avoid adding a voter more than once.
    
    private transient Ballots ballots = new Ballots();
    // actual votes cast

    synchronized void stop(Main main) throws ServletException {
        stopped = true;
        actual_end = new Date().toString();
        main.saveElection(this, false);
    }
    boolean isStopped() {
        return stopped;
    }
    
    /** Add the specified email addresses as voters. Return a map from voter emails
     *  to their voter keys (to be emailed to the voters). */
    synchronized Map addVoters(String auth_key, Collection voters_email, Main main)
    throws ServletException {
        Map ret = new HashMap();
        for (Iterator i = voters_email.iterator(); i.hasNext(); ) {
            String email = (String)i.next();
            Nonce n = new Nonce();
            n.md5(email);
            n.md5(auth_key);
            Name voter_key = n.md5(main.getPrivateHostID());
            Name voter_key_hash = new Nonce().md5(voter_key);
            if (authorized_voters.contains(voter_key_hash)) {
                // resending a key
                ret.put(email, voter_key);
            } else {
                authorized_voters.add(voter_key);
                ret.put(email, voter_key);           
            }
        }
        main.saveElection(this, false);
        return ret;
    }
    
    /** Add a ballot.
     * @return true if this is a revote.
     */
    synchronized boolean castBallot(Name voter_key,
            Ballot b, Main main) throws ServletException {
        boolean revote = false;
        if (ballots == null) throw new ServletException("ballots is null");

        if (voterKeyUsed(voter_key)) {
            revote = true;
            if (!allow_revotes) throw new ServletException("Revotes not allowed");
        }
        
        String dirname = main.dataDir() + File.separatorChar + "elections" +
        	File.separatorChar + id;
        String filename = dirname + File.separatorChar + "ballots";

        try {
            PrintWriter out = new PrintWriter(new FileOutputStream(filename, true));
            out.write(b.receipt_hash.toHex());
            out.write(" ");
            int n = b.rankings.length;
            for (int i = 0; i < n; i++) {
               if (i != 0) out.write(",");
               out.write(b.rankings[i].toString());
            }
            out.println();
            out.close();
            ballots.recorded_votes.put(b.receipt_hash, b);
        } catch (IOException e) {
            throw new ServletException("I/O error opening ballot file.", e);
        }
        
        try {
            PrintWriter out = new PrintWriter(new FileOutputStream(dirname +
                    File.separatorChar + "used_keys"), true);
            out.println(voter_key.toHex());
            out.close();
        } catch (IOException e) {
            throw new ServletException("I/O error opening used key file", e);
        }

        return revote;
    }
    
    synchronized void readBallots(String datadir) throws ServletException {
        ballots = new Ballots();
        String dir = datadir + File.separatorChar + "elections" +
			       File.separatorChar + id;
        String filename =  dir + File.separatorChar + "ballots";        
        BufferedReader r;        
        try {
            r = new BufferedReader(new FileReader(filename));
        }
        catch (FileNotFoundException exc) {
            return; // no ballots yet!
        }

        try {
            while (true) {
                String line = r.readLine();
                if (line == null) break;
                String[] tokens = line.split(" ");
                Name ballot_key = new Name(tokens[0]);
                String[] ranks_s = tokens[1].split(",");
                int n = choices.length;
                Rank[] ranks = new Rank[n];
                for (int i = ranks_s.length; i < ranks.length; i++)
                    ranks[i] = new SimpleRank(n);
                for (int i = 0; i < ranks_s.length; i++)
                    ranks[i] = Rank.parseRank(ranks_s[i]);
                // Note: ballots cast before a write-in will automatically
                // give write-in the lowest rank.
                Ballot b = new Ballot(ballot_key, ranks);
                ballots.recorded_votes.put(ballot_key, b);        
            }
            r.close();
        } catch (IOException exc) {
            throw new ServletException("IO Exception while reading ballot file " +
                    filename, exc);
        }
        filename = dir + File.separatorChar + "used_keys";       
        try {
            r = new BufferedReader(new FileReader(filename));
        }
        catch (FileNotFoundException exc) {
            return; // no ballots yet!
        }
        try {
            while (true) {
                String line = r.readLine();
                if (line == null) break;
                Name vkh = new Name(line);
                ballots.recorded_voters.add(vkh);
            }
        } catch (IOException exc) {
            throw new ServletException("I/O exception reading used keys", exc);
        }        
    }
        
    /**
     * @param voter_key
     * @return whether this voter key is authorized to vote
     * @throws ServletException
     */
    synchronized public boolean isAuthorized(Name voter_key) throws ServletException {
        return (authorized_voters.contains(new Nonce().md5(voter_key)));
    }
    
    synchronized public boolean voterKeyUsed(Name voter_key) throws ServletException {
        Name vkh = new Nonce().md5(voter_key);
        return (ballots.recorded_voters.contains(vkh));    
    }
    /**
     * @return
     */
    public int numAuthVoters() {
        return authorized_voters.size();
    }
    public int numVoted() {
        return ballots.recorded_votes.size();
    }
}
