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
	
	Main main() {
		return main;
	}
}
