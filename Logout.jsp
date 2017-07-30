<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>

<%
if (session != null)
    session.invalidate();
response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Page</title>
    </head>
    <body>
        
    </body>
</html>
