package civs;

/**
 * @author andru
 *
 */
abstract public class Ranking {
    abstract boolean leq(Ranking r);
    
    public Ranking create(int n) {
        return new SimpleRank(n);
    }
    
    public class SimpleRank extends Ranking {
        int rank;
        public SimpleRank(int rank_) {
            rank = rank_;
        }
        public boolean leq(Ranking r) {
            if (r instanceof SimpleRank) {
                SimpleRank sr = (SimpleRank)this;
                return rank <= sr.rank;
            } else {
                return false;
            }
        }
    }
    
    public class NoOpinion extends Ranking {
        public NoOpinion() {}
        public boolean leq(Ranking r) {
            return false;
        }
    }
}
