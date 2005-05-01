package civs;


import java.io.Serializable;
import java.util.Date;


import javax.servlet.ServletException;

import servlet.Name;


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
	
	synchronized void stop(Main main) throws ServletException {
		stopped = true;
		actual_end = new Date().toString();
		main.saveElection(this, false);
	}
	
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
	
	boolean started = false;
	boolean stopped = false;
	
	String[] authorized_keys;
		// The set of voter keys that have been authorized to vote.
	transient Ballots ballots;
		// actual votes cast
	
}
