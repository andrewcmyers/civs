package servlet;

import java.io.*;
import java.security.MessageDigest;

/**
 * @author andru
 *
 * Support for generating random nonces.
 */
public class Nonce {
	private String name;
	private static byte[] seed;
	{ initialize_seed(); }
	static MessageDigest md = new MessageDigest();
	
	/** A nonce object encapsulates a nonce. */
	public Nonce() {
		name = generate();
	}
	/** The name of the nonce as a string. */
	public String name() {
		return name;
	}
	/** Generate a random string that can be used as a nonce. */
	public static String generate() {
		md.reset();
		md.update(seed);
		byte[] result = md.digest();
		seed = result;
	}
	/** Seed the nonce generation process. */
	private static void initialize_seed() {
		char sep = File.separatorChar;
		File random = new File("" + sep + "dev" + sep + "random");
		if (random.isFile()) {
			FileInputStream in = new FileInputStream(random);
			byte[] b = new byte[16];
			int n = 0;
			while (n < 16) {
				n += in.read(b, n, 16-n);
			}
			seed = b;
		} else {
			long millis = System.currentTimeMillis();
			seed = new byte[] {(byte)(millis & 0xFF000000 >> 24),
					           (byte)(millis & 0xFF0000 >> 16),
							   (byte)(millis & 0xFF00 >> 8),
							   (byte)(millis & 0xFF)};


		}
		generate();
		// XXX now fold in private host id too.
	}
}
