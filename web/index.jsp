<%-- 
    Document   : index
    Created on : Apr 23, 2014, 9:44:09 AM
    Author     : christangga
--%>

<%@page import="Christ.Config"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Christ.CategoryList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Twistics</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <style type="text/css"> .bs-example{margin: 20 px; }></style>
 
        <nav class="navbar navbar-inverse" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <a class="navbar-brand" href="index.jsp">Twistics</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
          <li class="active"><a href="index.jsp">Home</a></li>
          <li><a>Result</a></li>
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
	<% String tString = request.getParameter("add_key");
            if (tString != null && tString != "") {
		if (!CategoryList.getList().contains(tString)) {
                    CategoryList.getList().add(tString);
		}
        } %>
            
            <fieldset>
                <legend><h1>Twistics</h1></legend>
            </fieldset>	
            <div class="col-md-3 column">
                <div class="panel-group" id="PLUS">
                    <div class="panel panel-default">
                            <div class="panel-heading">
                                     <a class="panel-title" data-toggle="collapse" data-parent="#PLUS" href="#proxy">Proxy Setting</a>
                            </div>
                            <div id="proxy" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <form name="proxy" action="index.jsp" method="get">
				Proxy Host: <input type="text" class="form-control" name="proxy_host" placeholder="cache.itb.ac.id"><br>
				Proxy Port: <input type="text" class="form-control" name="proxy_port" placeholder="8080"><br>
				Proxy Username: <input type="text" class="form-control" name="proxy_user"><br>
				Proxy Password: <input type="password" class="form-control" name="proxy_pass"><br>
				<input type="submit" value="Set Proxy" onclick="alert('Proxy has been set');">
			</form>
			<% if (request.getParameter("proxy_host") != null && request.getParameter("proxy_port") != null && request.getParameter("proxy_user") != null
					&& request.getParameter("proxy_pass") != null) {
				Config.setHost(request.getParameter("proxy_host"));
				Config.setPort(request.getParameter("proxy_port"));
				Config.setUser(request.getParameter("proxy_user"));
				Config.setPass(request.getParameter("proxy_pass"));
			}
			%>
                                    </div>
                            </div>
                    </div>
                    <div class="panel panel-default">
                            <div class="panel-heading">
                                     <a class="panel-title" data-toggle="collapse" data-parent="#PLUS" href="#keyword">Add Keywords</a>
                            </div>
                            <div id="keyword" class="panel-collapse collapse">
                                    <div class="panel-body">
                                            <form role="form" class="form-inline" name="asf" action="index.jsp" method="get">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="add_key" placeholder="Enter new Keyword">
                                                    <button type="submit" class="btn" >Add</button>
                                                </div>
                                            </form>  
                                    </div>
                            </div>
                    </div>
                    <div class="panel panel-default">
                            <div class="panel-heading">
                                     <a class="panel-title" data-toggle="collapse" data-parent="#PLUS" href="#anggota">Member</a>
                            </div>
                            <div id="anggota" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <a href ="https://www.facebook.com/eldwin.christian" target="_blank" title="Facebook">Eldwin Christian </a>- 13512002 <br>    
                                        <a href ="https://www.facebook.com/riady.sastrakusuma" target="_blank" title="Facebook">Christ Angga Saputra </a> - 13512019 <br>
                                        <a href ="https://www.facebook.com/christ.angga.saputra" target="_blank" title="Facebook">Riady Sastra Kusuma </a>- 13512024
                                    </div>
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-md-5 column">
                <form role="form" class="form-group" name="input" action="result.jsp" method="get">
                    <div class="form-horizontal">
                        <h4><span class="label label-default">Pencarian Twitter: </span></h4>
                            <input type="text" class="form-control" name="search" placeholder="#lalinbdg"><br>
                            <% if (!CategoryList.getList().contains("macet")) {
                                CategoryList.getList().add("macet");
                            }
                            if (!CategoryList.getList().contains("kecelakaan")) {
                                CategoryList.getList().add("kecelakaan");
                            } %>
                            
			<% for (String category : CategoryList.getList()) {
				if (!category.equalsIgnoreCase("unknown")) {
                                    %><span class="label label-default"><%out.print("Keyword " + category + ": "); %> </span>
                                        <input type="text" class="form-control" class="form-control" name="<%= "key_" + category %>" placeholder="<%= category %>">
			<% }
			} %>
                        
                        <br><label> Algoritma  : </label>
                         
                
                <div class="radio">
                    <label>
                        <input type="radio" name="algorithms" value="bm" checked>
                        Boyer-Moore
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="algorithms" value="kmp">
                        Knuth-Morris-Pratt
                    </label>
                </div>
                        <button type="submit" class="btn" for="add_key"> Analisis </button>
                    </div>
                </form>
            </div>
            
            <div class="col-md-4 column">
                 <iframe
			<%String sumber="https://www.google.com/maps/embed/v1/place?key=AIzaSyCJdIHonRjJ6vgBD3N1immMJ1BAxNp_Xhg&q=itb,Bandung+Indonesia"; %>
                        width="400"
			height="400"
			frameborder="0" style="border:0"
			src="<%=sumber%>">
		</iframe>
            </div>
    </body>
</html>
