/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Christ;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author christangga
 */
public class StringMatcher {
	
	public StringMatcher() {
	
	}
	
	public static String regex(String text) {
		Pattern p = Pattern.compile("(?i)(((ja*la*n)( ke| raya| tol)|(je*mba*ta*n)|(gedung)|(taman)|(jl.)) \\w+)|((di |ke )((kawasan |depan |pertigaan |perempatan |daerah |tol )?)(sd |smp |sma |ka*ntor |ge*dung )?\\w+)");
		Matcher m = p.matcher(text);
		String hasil = "";
                if(m.find()){
                    hasil += m.group();
                }
		return hasil;
		
	}
        public static String Remov(String text) {
		String hasil = text.replaceAll("[^a-zA-Z]","");
		return hasil;
	}
        
	public static int KMP(String text, String pattern) {
            int n = text.length();
            int m = pattern. length();
            int fail[] = computeFail(pattern);
            int i = 0, j = 0;
            
            while (i<n) {
				if (pattern.charAt(j) == text.charAt(i)) {
					if (j == m-1) {
						return i-m+1; // match
					}
					++i; ++j;
				} else if (j>0) {
					j = fail[j-1];
				} else {
					++i;
				}
            }
			return -1; // no match
        }
		
		private static int[] computeFail(String pattern) {
			int fail[] = new int[pattern.length()];
			fail[0] = 0;
			int m = pattern.length();
			int j=0; int i=1;
			
			while (i<m) {
				if (pattern.charAt(j) == pattern.charAt(i)) { // j+1 chars match
					fail[i] = j+1;
					++i; ++j;
				} else if (j>0) { // j follows matching prefix
					j = fail[j-1];
				} else { // no match
					fail[i] = 0;
					++i;
				}
			}
			return fail;
		}
		
		public static int BM(String text, String pattern) {
			int last[] = buildLast(pattern);
			int n = text.length();
			int m = pattern.length();
			int i = m-1;
			
			if (i>n-1) {
				return -1; // no match if pattern is longer than text
			}
			int j = m-1;
			do {
				try {
					if (pattern.charAt(j) == text.charAt(i)) {
						if (j==0) {
							return i; // match
						} else { // looking-glass technique
							--i; --j;
						}
					} else { // character jump technique
						int lo = last[text.charAt(i)]; // last occurence
						i = i+m-Math.min(j, 1+lo);
						j = m-1;
					}
				} catch (Throwable e) {
					i = i+m-j;
					j = m-1;
				}
			} while (i<=n-1);
			
			return -1; // no match
		}
		
		private static int[] buildLast(String pattern) {
			int last[] = new int[128]; // ASCII char set
			
			for (int i=0; i<128; ++i) {
				last[i] = -1; // initialize array
			}
			for (int i=0; i<pattern.length(); ++i) {
				last[pattern.charAt(i)] = i;
			}
			
			return last; // return array storing index of last occurence of each ASCII char in pattern
		}
}
