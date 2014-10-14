/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Christ;

/**
 *
 * @author christangga
 */
public class Config {
	private static String host = "";
	private static String port = "";
	private static String user = "";
	private static String pass = "";

	public Config() {}
	
	public static String getHost() {
		return host;
	}

	public static String getPort() {
		return port;
	}

	public static String getUser() {
		return user;
	}

	public static String getPass() {
		return pass;
	}

	public static void setHost(String host) {
		Config.host = host;
	}

	public static void setPort(String port) {
		Config.port = port;
	}

	public static void setUser(String user) {
		Config.user = user;
	}

	public static void setPass(String pass) {
		Config.pass = pass;
	}
	
}
