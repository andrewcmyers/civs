package servlet;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;

/**
 * @author andru
 * 
 * Support for generating random nonces.
 * Should this be all static or should there be a different Nonce
 * per servlet or per session? */
public class Nonce {
	private String name;
	private Servlet servlet;
	private byte[] seed;
	MessageDigest md;

	/** A nonce object encapsulates a nonce. 
	 * @throws ServletException
	 * @throws IOException*/
	public Nonce(Servlet srv) throws ServletException {
		servlet = srv;
		try { System.out.println("Initializing MD5");
		      md = MessageDigest.getInstance("MD5"); }
		  catch (NoSuchAlgorithmException e) {
		  	System.out.println("Cannot create an MD5 digester.");
		  }
		initialize_seed();
		name = generate();
	}
	/** The name of the nonce as a string. */
	public String name() { return name;	}
	/** Generate a random string that can be used as a nonce. */
	public String generate() {
		md.reset();
		md.update(seed);
		byte[] result = md.digest();
		seed = result;
		return new String(result);
	}
	void addRandom() throws IOException {		
		char sep = File.separatorChar;
		File random = new File("" + sep + "dev" + sep + "random");
		
		FileInputStream in = new FileInputStream(random);
		byte[] b = new byte[16];
		int n = 0;
		while (n < 16) {
			n += in.read(b, n, 16-n);
		}
		md.update(b);
		return;
	}
	void addHostID() throws ServletException {
		String hostid = servlet.getPrivateHostID();

		if (hostid == null) {
			System.out.println("Error: cannot find private host ID in configuration.");
		}
		md.update(hostid.getBytes());
	}
	void addCurrentTime() {
		long millis = System.currentTimeMillis();
		byte[] b = new byte[] {(byte)(millis & 0xFF000000 >> 24),
				(byte)(millis & 0xFF0000 >> 16),
				(byte)(millis & 0xFF00 >> 8),
				(byte)(millis & 0xFF)};		
		
		md.update(b);
	}
	/** Seed the nonce generation process. 
	 * @throws ServletException
	 * @throws IOException*/
	private void initialize_seed() throws ServletException {
		md.reset();
		
		addHostID();
		
		try { addRandom(); }	
		catch (IOException exc) {}
		/* If we can't read from /dev/random, don't bother. */
		addCurrentTime();
		
		seed = md.digest();
	}
}
