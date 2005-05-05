package civs;

import java.util.Random;

/**
 * @author andru
 *
 * Miscellaneous utilities.
 */
public class Misc {
    static boolean isValidEmail(String email) {
        return true;
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
