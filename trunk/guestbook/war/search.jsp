<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="guestbook.GuestBookEntry" %>
<%@page import="guestbook.SearchJanitor"%>
<%@page import="com.googlecode.objectify.ObjectifyService"%>
<%@page import="com.googlecode.objectify.Objectify"%>

<html>
  <head>
    <title>Searchable Guestbook Example</title>
  </head>

  <body>

    <form action="/search.jsp" method="get">
      <div><input name="search"></input></div>
      <div><input type="submit" value="Search" /></div>
    </form>

<%
	String searchString = request.getParameter("search");

if (searchString != null) {
	
	out.println("Results for:<b> " + searchString + "</b>");
	
		List<GuestBookEntry> searchResults = SearchJanitor.searchGuestBookEntries(searchString);
	
	
    if (searchResults.isEmpty()) {
%>
    	<p>No results found. Please try different search.</p>
    	<%
    		} else {
    	    	        for (GuestBookEntry g : searchResults) {

    	%>
    	<blockquote><%= g.getContent() %></blockquote>
    	<%
    	        }
    	    }
}

%>


	<a href="guestbook.jsp">Back to main page</a>
	
	    <p>
    Example project <a href="http://code.google.com/p/guestbook-example-appengine-full-text-search/">guestbook-example-appengine-full-text-search</a>.
    </p>

  </body>
</html>
