package civs;

import servlet.Action;

/**
 * @author andru
 *
 * CIVS actions all know their servlet.
 */
abstract public class CIVSAction extends Action {
    Main main;
    CIVSAction(Main main_) {
        super(main_);
        main = main_;
    }
    
    /**
     * @param string
     * @param s
     */
    public CIVSAction(String n, Main m) {
        super(n, m);
        main = m;
    }
    
    Main main() {
        return main;
    }

    public boolean equivalentTo(Action a) {
	// XXX check/fix/override me!
	return this == a;
    }

    public Action intern() {
	// XXX check/fix/override me!
	return this;
    }
}
