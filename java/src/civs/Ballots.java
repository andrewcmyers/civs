package civs;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * Ballots records all the data sent by voters. This information is
 * reconstructed by reading the vote log file. The vote log file is
 * constructed incrementally by appending to the end, which avoids
 * the need to lock the file down during the casting of each vote.
 */
public class Ballots {
    /** A map from used ballot keys to corresponding ballots. */
    Map recorded_votes = new HashMap();
    /** A set of hashes (Names) of used voter keys */
    Set recorded_voters = new HashSet();
}
