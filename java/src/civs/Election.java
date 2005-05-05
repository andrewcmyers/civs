package civs;


import java.io.Serializable;
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
 * @author andru
 *
 * An Election contains the information describing an election. It
 * is serialized to a file. It is not modified by voter actions, only
 * by the supervisor. Locking is provided by the servlet, not through the
 * file system.
 * 
 * All election data is stored in CIVSDATADIR/elections/id/
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
    
    private transient Ballots ballots;
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
            Name voter_key = Nonce.md5(email + auth_key + main.getPrivateHostID());
            Name voter_key_hash = Nonce.md5(voter_key);
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
    /**
     * @param voter_key
     * @return whether this voter key is authorized to vote
     * @throws ServletException
     */
    public boolean isAuthorized(Name voter_key) throws ServletException {
        return (authorized_voters.contains(Nonce.md5(voter_key)));
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

