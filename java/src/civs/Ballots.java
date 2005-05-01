package civs;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Ballots records all the data sent by voters. This information is
 * reconstructed by reading the vote log file. The vote log file is
 * constructed incrementally by appending to the end, which avoids
 * the need to lock the file down during the casting of each vote.
 */
public class Ballots {
    Ballot[] recorded_votes;
    String[] used_voter_keys;
    Ballots(String datadir, Election e) throws IOException {
        String dir = datadir + File.separatorChar +
        "elections" + File.separatorChar +
        e.id;
        FileInputStream fs = new FileInputStream(new File(dir + File.separatorChar + "votes"));
        
    }
}
