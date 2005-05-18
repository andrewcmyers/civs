package civs;

import servlet.Name;

/**
 * A single ballot cast by a voter.
 */
public class Ballot {
    Name receipt_hash;
    Rank[] rankings;
    
    Ballot(Name v, Rank[] r) {
        receipt_hash = v;
        rankings = r;
    }
}
