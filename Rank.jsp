<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" session="true" %>

<%!
private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/jee";
private static final String USER = "root";
private static final String PASS = "password";
private int id, rank;

public void DatabaseAccess(HttpServletRequest request, HttpServletResponse response)
{
    Connection conn = null;
    Statement stmt = null;
    try
    {
        Class.forName(JDBC_DRIVER);
        System.out.println("Connecting to the Database...");
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        System.out.println("Creating Statement...");
        stmt = conn.createStatement();
        id = Integer.parseInt(request.getSession().getAttribute("application_id").toString());
        String sql = "SELECT rank FROM rank where application_id = " + id;
        ResultSet rs = stmt.executeQuery(sql);
        rs.next();
        rank = rs.getInt(1);
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
if (session.getAttribute("application_id") == null)
    response.sendRedirect("index.jsp");
else
    this.DatabaseAccess(request, response);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css">
        <title>Student Details</title>
    </head>
    <body>
        <center><header>Joint Entrance Exam-2017</header></center>
        <nav>
            <div class="menu"><a href="StudentDetails.jsp">Student Details</a></div>
            <div class="menu"><a href="AnswerSheet.jsp">Answer Sheet/Score</a></div>
            <div class="menu_selected"><a href="#">Rank</a></div>
            <div class="menu"><a href="Logout.jsp">Logout</a></div></div>
        </nav>
        <section class="student_detail_section" style="padding: 10% 3% 15% 3%;">
            <font style="font-size: 3vw;"><center><b>Congratulations!!!</b></center></font><br/>
            <center>Your Rank in Joint Entrance Exam is <b><u><%= rank %></u></b>.</center>
            
        </section>
        
        </div>
    </body>
</html>
