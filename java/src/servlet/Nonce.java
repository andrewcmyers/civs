package servlet;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;

/**
 * @author andru
 * 
 * Support for generating random nonces. A Nonce objects is
 * a generator for nonces.
 **/
public class Nonce {
    private Servlet servlet;
    private byte[] seed;
    MessageDigest md;
    
    /** A nonce object encapsulates a nonce. 
     * @throws ServletException
     * @throws IOException*/
    public Nonce(Servlet srv) throws ServletException {
        servlet = srv;
        md = newMD5Digest();
        initialize_seed();
    }
    
    /** Create a nonce generator that is a straight MD5 digest. */
    public Nonce() throws ServletException {
        md = newMD5Digest();
        md.reset();
    }
    
    /** Generate a pseudo-random sequence of bytes that
     * can be used as a nonce. */
    public Name generate() {
        md.reset();
        md.update(seed);
        seed = md.digest();
        return digestToName(seed);
        
    }
    public static Name digestToName(byte[] digest) {
        byte[] result = new byte[8];
        for (int i = 0; i < 8; i++) {
            result[i] = digest[i];
        }
        return new Name(result);
    }
    public static MessageDigest newMD5Digest() throws ServletException {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new ServletException("Cannot construct MD5 digests.");
        }
        return md;
    }
    public Name md5(byte[] bytes) throws ServletException {
        md.update(bytes);
        return digestToName(md.digest());
    }
    public Name md5(String s) throws ServletException {
        return md5(s.getBytes());	
    }
    public Name md5(Name n) throws ServletException {
        return md5(n.bytes);
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
