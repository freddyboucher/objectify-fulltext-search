<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="guestbook.GuestBookEntry"%>
<%@page import="com.googlecode.objectify.Objectify"%>
<%@page import="com.googlecode.objectify.ObjectifyService"%>
<%@page import="com.googlecode.objectify.Query"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.jasper.tagplugins.jstl.ForEach"%><html>
<head>
<title>Searchable Google App Engine Guestbook Example</title>

</head>

<body>

<form action="/search.jsp" method="get"><input name="search"></input>
<input type="submit" value="Search" /></form>

<%
	// BE CAREFUL with this line! This a example, but in a real world project, you should look a better
	// place for register an entity, at the very begining of your application is recommended.
	ObjectifyService.register(GuestBookEntry.class);

	Objectify ofy = ObjectifyService.begin();
	String guestBookEntryParameter = request.getParameter("entry");
	if (guestBookEntryParameter != null) {
		GuestBookEntry guestBookEntry = new GuestBookEntry();
		guestBookEntry.contentForSearch(guestBookEntryParameter);
		ofy.put(guestBookEntry);
	}
	List<GuestBookEntry> guestBookEntries = new ArrayList<GuestBookEntry>();
	Query<GuestBookEntry> query = ofy.query(GuestBookEntry.class);

	for (GuestBookEntry gb : query) {
		guestBookEntries.add(gb);
	}

	if (guestBookEntries.isEmpty()) {
%>


<p>The guestbook has no messages.</p>
<%
	} else {
		for (GuestBookEntry g : guestBookEntries) {
%>
<blockquote><%=g.getContent()%></blockquote>
<%
	}
	}
%>

<form action="/guestbook.jsp" method="post">
<div><textarea name="entry" rows="3" cols="60"></textarea></div>
<div><input type="submit" value="Post guestbook entry" /></div>
</form>

<p>Example project <a
	href="http://code.google.com/p/guestbook-example-appengine-full-text-search/">guestbook-example-appengine-full-text-search</a>.
</p>

</body>
</html>
