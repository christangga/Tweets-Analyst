package Christ;




import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author christangga
 */
public class CategoryList {
	private static List<String> L = new ArrayList<String>();
	
	private CategoryList() {}
	
	public static List<String> getList() {
		return L;
	}
	/*out.println("Showing results for query: \"" + request.getParameter("search") + "\"<br>");
	int count = 0;
	for (Status status : result.getTweets()) {
		out.println(++count + " "); %> <img src=<%= status.getUser().getBiggerProfileImageURL() %> alt="profilePicture" width="48" height="48">
		<% out.println(status.getUser().getName() + " "
			+ "@" + status.getUser().getScreenName() + " : "
			+ status.getText() + "<br>");
	}*/
}
