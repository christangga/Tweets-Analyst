<%-- 
    Document   : search
    Created on : Apr 23, 2014, 7:11:10 PM
    Author     : christangga
--%>

<%@page import="Christ.Config"%>
<%@page import="twitter4j.URLEntity"%>
<%@page import="Christ.StringMatcher"%>
<%@page import="Christ.CategoryList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="twitter4j.Status"%>
<%@page import="twitter4j.QueryResult"%>
<%@page import="twitter4j.Query"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Result - Twistics</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <style type="text/css"> .bs-example{margin: 20 px; }></style>
 
        <nav class="navbar navbar-inverse" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.jsp">Twistics</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
          <li><a href="index.jsp">Home</a></li>
          <li class="active" ><a>Result</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li>
            <a data-toggle="modal" href="#about"><em class="glyphicon glyphicon-info-sign"></em> About Us</a>
        </li>
      </ul>
    </div>
  </div>
</nav>  
<div class="modal fade" id="about" tabindex="-1" role="dialog" aria-labelledby="aboutlabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="aboutlabel">String Matching</h4>
			  </div>
			  <div class="modal-body">
			  <div class="row clearfix">
				<div class="col-sm-3">
					<img class="img-rounded" src="img/RiCE.png">
				</div>
				<div class="col-sm 3">
					Author : <br>
					Eldwin Christian (13512002) <br>
					Christ Angga Saputra (13512019)<br>
                                        Riady Sastra Kusuma (13512024)
				</div>
			  </div>
			  </div>
			</div>
		  </div>
		</div>
    
</head>
    <body background="img/bg.jpg">
        <% ConfigurationBuilder cb = new ConfigurationBuilder(); 
        if (!Config.getHost().equals("") && !Config.getPort().equals("") && !Config.getUser().equals("") && !Config.getPass().equals("")) {
			cb.setHttpProxyHost(Config.getHost());
			cb.setHttpProxyPort(Integer.parseInt(Config.getPort(), 10));
			cb.setHttpProxyUser(Config.getUser());
			cb.setHttpProxyPassword(Config.getPass());
		}cb.setDebugEnabled(true)
            .setOAuthConsumerKey("T9NUdDX6v1h9ePI61RKi4g")
            .setOAuthConsumerSecret(
                "xi4EIC9so6e6n8oOM3ggx2zbayj3JWhSpEj165bEJU")
            .setOAuthAccessToken(
                "178369831-97z3fDZvMH0e8Ne0ot7WzFXayAPSU2eOx9VzLr4y")
            .setOAuthAccessTokenSecret(
                "KwTHAIi2bWAVWOPtNM4NoYaiAwLvrkGWqWHv6jGBKffF5");
        TwitterFactory tf = new TwitterFactory(cb.build());
        Twitter twitter = tf.getInstance(); %>
        
        <% // Search 100 latest tweets
        Query query = new Query(request.getParameter("search") + " +exclude:retweets");
        query.setCount(100);
        QueryResult result = twitter.search(query); %>
            <fieldset>
                <legend><h1>Searching Results</h1></legend>
            </fieldset>
            <% List<Status> visited_tweet_list = new ArrayList<Status>();
		for (String category : CategoryList.getList()) {
			List<Status> tweet_list = new ArrayList<Status>();
			int tweet_count = 0;
			String tweet_location = "";
			for (Status status : result.getTweets()) {
				if (request.getParameter("algorithms").equals("bm")) {
					for (String s : request.getParameter("key_" + category).split(" *; *")) {
						if (StringMatcher.BM(status.toString().toLowerCase(), s.toLowerCase()) > 0 && !visited_tweet_list.contains(status)) {
							++tweet_count;
                                                        String tString = StringMatcher.regex(status.getText());
							if (tweet_location.equals("") && !tString.equals("")) {
                                                            tweet_location += tString;
							} else if (!tString.equals("")) {
                                                            tweet_location += ", " + tString;
							}
							tweet_list.add(status);
							visited_tweet_list.add(status);
						}
					}
				} else if (request.getParameter("algorithms").equals("kmp")) {
					for (String s : request.getParameter("key_" + category).split(" *; *")) {
						if (StringMatcher.KMP(status.toString().toLowerCase(), s.toLowerCase()) > 0 && !visited_tweet_list.contains(status)) {
							++tweet_count;
                                                        String tString = StringMatcher.regex(status.getText());
							if (tweet_location.equals("") && !tString.equals("")) {
                                                            tweet_location += tString;
							} else if (!tString.equals("")) {
                                                            tweet_location += ", " + tString;
							}
							tweet_list.add(status);
							visited_tweet_list.add(status);
						}
					}
				}
			}
			out.println("<b>Kategori " + category.toUpperCase() + "</b><br>");
			out.println("Jumlah: " + tweet_count + "<br>");
			out.println("Lokasi: " + tweet_location + "<br>");
			out.println("Daftar tweets:<br>");%><hr><%
			for (Status status : tweet_list) {
                            %>  
                            <div class="row">
                                <%String source="http://twitter.com/"+status.getUser().getScreenName()+"/status/"+status.getId();%>
                    <div class="col-md-1">
                        <div class="row text-center"><a href='<%=source%>' title='<%=source%>'><img src=<%= status.getUser().getBiggerProfileImageURL() %> class="img-rounded" alt="profilePicture" width="64" height="64"></a></div>
                        </div>
                    <div class="col-md-11">
                        <div class="col-md-8">
                            <%String ID="http://twitter.com/"+status.getUser().getScreenName();%>    
                        <a href='<%=ID%>' title='<%=ID%>' target="_blank"><%out.print(status.getUser().getName());%></a><% out.println("@" + status.getUser().getScreenName() + "<br>");%>
			<%for(String s : status.getText().split(" ")){
                            if(s.startsWith("#")){
                                String hashtag="http://twitter.com/search?q=%23"+StringMatcher.Remov(s)+"&src=hash";
                                %><a href='<%=hashtag%>' title='<%=hashtag%>' target="_blank"><%out.print(s+" ");%></a><% 
                            }
                            else if(s.startsWith("@")){
                                String sumber="http://twitter.com/@"+StringMatcher.Remov(s);
                                %><a href='<%=sumber%>' title='<%=sumber%>' target="_blank"><%out.print(s+" ");%></a><% 
                            }
                            else{
                                out.print(s+" ");
                            }   
                        }%> </div><div class="col-md-4"><iframe
			<%String sumber="https://www.google.com/maps/embed/v1/place?key=AIzaSyCJdIHonRjJ6vgBD3N1immMJ1BAxNp_Xhg&q="+status.getUser().getLocation()+"&zoom=21"; %>
                        width="200"
			height="200"
			frameborder="0" style="border:0"
			src="<%=sumber%>">
                            </iframe></div>
                <br></div></a></div> <hr> <% 
                    }	
		}
		
		// Category UNKNOWN
		List<Status> tweet_list = new ArrayList<Status>();
		int tweet_count = 0;
		String tweet_location = "";
		for (Status status : result.getTweets()) {
			if (request.getParameter("algorithms").equals("bm")) {
				if (!visited_tweet_list.contains(status)) {
					++tweet_count;
                                        String tString = StringMatcher.regex(status.getText());
                                        if (tweet_location.equals("") && !tString.equals("")) {
                                            tweet_location += tString;
                                        } else if (!tString.equals("")) {
                                            tweet_location += ", " + tString;
                                        }
					tweet_list.add(status);
					visited_tweet_list.add(status);
				}
			} else if (request.getParameter("algorithms").equals("kmp")) {
				if (!visited_tweet_list.contains(status)) {
					++tweet_count;
                                        String tString = StringMatcher.regex(status.getText());
                                        if (tweet_location.equals("") && !tString.equals("")) {
                                            tweet_location += tString;
                                        } else if (!tString.equals("")) {
                                            tweet_location += ", " + tString;
                                        }
					tweet_list.add(status);
					visited_tweet_list.add(status);
				}
			}
		}
		out.println("<br><b>Kategori UNKNOWN</b><br>");
		out.println("Jumlah: " + tweet_count + "<br>");
		out.println("Lokasi: " + tweet_location + "<br>");
		out.println("Daftar tweets:<br>");%><hr><%
		for (Status status : tweet_list) {
                            %>  <div class="row">
                                <%String source="http://twitter.com/"+status.getUser().getScreenName()+"/status/"+status.getId();%>
                    <div class="col-md-1">
                        <div class="row text-center"><a href='<%=source%>' title='<%=source%>'><img src=<%= status.getUser().getBiggerProfileImageURL() %> class="img-rounded" alt="profilePicture" width="64" height="64"></a></div>
                    </div>
                    <div class="col-md-11">
                        <div class="col-md-8"><%String ID="http://twitter.com/"+status.getUser().getScreenName();%>    
                        <a href='<%=ID%>' title='<%=ID%>'><%out.print(status.getUser().getName());%></a><% out.println("@" + status.getUser().getScreenName() + "<br>");%>
			<%for(String s : status.getText().split(" ")){
                            if(s.startsWith("#")){
                                String hashtag="http://twitter.com/search?q=%23"+StringMatcher.Remov(s)+"&src=hash";
                                %><a href='<%=hashtag%>' title='<%=hashtag%>'><%out.print(s+" ");%></a><% 
                            }
                            else if(s.startsWith("@")){
                                String sumber="http://twitter.com/@"+StringMatcher.Remov(s);
                                %><a href='<%=sumber%>' title='<%=sumber%>'><%out.print(s+" ");%></a><% 
                            }
                            else{
                                out.print(s+" ");
                            }   
                        }%></div><div class="col-md-4"><iframe
			<%String sumber="https://www.google.com/maps/embed/v1/place?key=AIzaSyCJdIHonRjJ6vgBD3N1immMJ1BAxNp_Xhg&q="+status.getUser().getLocation()+"&zoom=21"; %>
                        width="200"
			height="200"
			frameborder="0" style="border:0"
			src="<%=sumber%>">
                            </iframe></div><br></div></a></div> <hr> <% 
                    }%>
                
                <footer>
                    <span class="pull-right">
                        <a href="#">
                            <img class="img-rounded" src="img/RiCE.png">
                        </a>
                    </span>
                 </footer>
         

    </body>
</html>
