<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" session="false" %>
<%!
private int count;
private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/jee";
private static final String USER = "root";
private static final String PASS = "password";
private int applicationID;
%>

<%!
public void jspInit()
{
    this.count = 11;
}
%>

<%!
public void jspDestroy()
{
    this.count = 11;
}
%>

<%!
public void DatabaseAccess(HttpServletRequest request)
{
    Connection conn = null;
    Statement stmt = null;
    try
    {
        Class.forName(JDBC_DRIVER);
        System.out.println("Connecting to the Database...");
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        System.out.println("Creating Statement...");
        stmt = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
        String sql = "INSERT INTO student_information (`firstname`, `lastname`, `fathersname`, `mothersname`, `dob`,"
                + "`emailid`, `password`, `address`, `mobile`) VALUES ('" + request.getParameter("firstname") + "', '"
                + request.getParameter("lastname") + "', '" + request.getParameter("fathersname") + "', '"
                + request.getParameter("mothersname") + "', '" + request.getParameter("dob") + "', '"
                + request.getParameter("email") + "', '" + request.getParameter("password") + "', '"
                + request.getParameter("address") + "', '" + request.getParameter("mobile") + "');";
        stmt.executeUpdate(sql);
        sql = "SELECT max(application_id) as maxi from student_information;";
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next())
        {
            this.applicationID = rs.getInt(1);
        }
        System.out.println(rs.getInt(1));
        rs.close();
        stmt.close();
        conn.close();
    }
    catch (SQLException se)
    {
        se.printStackTrace();
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        try
        {
            if (stmt != null)
                stmt.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        
        try
        {
            if (conn != null)
                conn.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        System.out.println("Good Bye!!!");
    }
}
%>

<%
    if (request.getMethod().equals("GET"))
        response.sendRedirect("index.jsp");
%>

<%
if (this.count == 11)
    this.DatabaseAccess(request);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css">
        <title>Registration Successful!</title>
    </head>
    <body>
        <center><header>Joint Entrance Exam-2017</header></center>
        <section class="onesection">
            Congratulations! Your Registration is successful.<br/><br/>
            <font style="font-size: 3vw;">Your Application id is <b><%= this.applicationID %></b>.</font><br/><br/>
            You can login with this Application id from the main page.<br/>
            <%
                this.count--;
                if (this.count == 0)
                {
                    this.destroy();
                    response.sendRedirect("index.jsp");
                }
                else if (this.count == 1)
                    out.println("This page will be redirected to the main page in <b><u>" + count + "</u></b> second.");
                else
                    out.println("This page will be redirected to the main page in <b><u>" + count + "</u></b> seconds.");
                response.setIntHeader("Refresh", 1);
            %>
        </section>
    </body>
</html>
