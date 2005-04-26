package servlet;

/**
 * @author andru
 * @deprecated Not currently in use.
 */
public class Mutex {
	boolean locked;
	public Mutex() {
		locked = false;
	}
	public synchronized void acquire() {
		while (locked) {
			try { wait(); }
			catch (InterruptedException e) {}
		}
		locked = true;
	}
	public synchronized void release() {
		locked = false;
		notify();
	}
}
