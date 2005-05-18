package civs;

/**
 * @author andru
 *
 */
abstract public class Rank {
    abstract boolean leq(Rank r);
    
    public Rank create(int n) {
        return new SimpleRank(n);
    }

    public final static NoOpinion noOpinion = new NoOpinion();

    static Rank parseRank(String s) throws NumberFormatException {
        if (s.equals("No opinion")) return noOpinion; // XXX internationalization?
        try {
            return new SimpleRank(Integer.parseInt(s));
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    
}


class SimpleRank extends Rank {
    int rank;
    public SimpleRank(int rank_) {
        rank = rank_;
    }
    public boolean leq(Rank r) {
        if (r instanceof SimpleRank) {
            SimpleRank sr = (SimpleRank)this;
            return rank <= sr.rank;
        } else {
            return false;
        }
    }
    public String toString() {
        return Integer.toString(rank);
    }
}

 class NoOpinion extends Rank {        
    public NoOpinion() {}
    public boolean leq(Rank r) {
        return false;
    }
    public String toString() {
        return "*";
    }
}

