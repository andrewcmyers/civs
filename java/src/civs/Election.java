/*
 * Created on Mar 13, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package civs;

import java.io.Serializable;

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
	boolean started;
	boolean stopped;
	
	String title; // election title
	String name;  // name of the election supervisor
	String email; // supervisor email
	String description; // description of the election
	String ends; // description of when the election ends.
	transient String[] addresses; // email addresses of the voters
	String[] choices;
	transient Ballots ballots; // actual voters
	String auth_key;
	String control_key;
	boolean proportional;
	boolean allow_writeins;
	boolean allow_revotes;
	int num_winners;
	
	public String getId() { return id; }
}
