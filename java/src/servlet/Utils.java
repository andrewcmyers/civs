package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Random;

/**
 * @author andru
 *
 * Utility functions.
 */
public class Utils {
    /** Return the contents of a file as an array of bytes. Throws an IOException
     * if the file cannot be read or if it becomes shorter during the read.
     * 
     * @param filename
     * @return the file data.
     * @throws IOException
     */
    public static byte[] fileContents(String filename) throws IOException {
        File f = new File(filename);
        FileInputStream in = new FileInputStream(new File(filename));
        try {
            int len = in.available();
            byte[] b = new byte[len];
            int n = 0;
            while (n < len) {
                n += in.read(b, n, len-n);
            }
            return b;
        } finally {
            in.close();
        }
    }

    /**
     * @param n the number of elements in the permutation, n>=1.
     * @return an array of length n with the elements 0..n-1 in random order.
     */
    public static int[] randomPermutation(int n) {
        int[] result = new int[n];
        
        for (int i = 0; i < n; i++) {
            result[i] = i;
        }
        Random r = new Random();
        
        for (int i = 0; i < n-1; i++) {
            int j = i + r.nextInt(n-i);
            int tmp = result[j];
            result[j] = result[i];
            result[i] = tmp;
        }
        
        return result;
    }
}
