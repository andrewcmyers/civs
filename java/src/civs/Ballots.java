/*
 * Created on Mar 13, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package civs;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Ballots records all the data sent by voters. This information is
 * reconstructed by reading the vote log file.
 */
public class Ballots {
	Ballot[] recorded_votes;
	String[] used_voter_keys;
	Ballots(String datadir, Election e) throws IOException {
		File f = new File(datadir + File.separatorChar +
				          "elections" + File.separatorChar +
				          e.getId());
		FileInputStream fs = new FileInputStream(f);

	}
}
