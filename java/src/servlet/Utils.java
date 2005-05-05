package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

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


}
