/*
 * Created on Mar 14, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package servlet;

/**
 * @author andru
 *
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
