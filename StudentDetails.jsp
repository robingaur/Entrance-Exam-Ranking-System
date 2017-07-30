<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" session="true" %>

<%!
private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/jee";
private static final String USER = "root";
private static final String PASS = "password";
private String name, email, father, mother, address, date;
private int id;
private long mobile;

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
        String sql = "SELECT * FROM student_information where application_id = " + id;
        ResultSet rs = stmt.executeQuery(sql);
        rs.next();
        name = rs.getString("firstname") + " " + rs.getString("lastname");
        father = rs.getString("fathersname");
        mother = rs.getString("mothersname");
        date = rs.getDate("dob").toString();
        email = rs.getString("emailid");
        mobile = rs.getLong("mobile");

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
            <div class="menu_selected"><a href="#">Student Details</a></div>
            <div class="menu"><a href="AnswerSheet.jsp">Answer Sheet/Score</a></div>
            <div class="menu"><a href="Rank.jsp">Rank</a></div>
            <div class="menu"><a href="Logout.jsp">Logout</a></div></div>
        </nav>
        <section class="student_detail_section">
            <font style="font-size: 1.6vw;"><center><b>Student Details</b></center></font><br/><br/>
            <table border='1' cellpadding='15' bordercolor='white'>
                <col width='250'>
                <col width='800'>
                <tr>
                    <td>Application Number: </td><td><%= this.id %></td>
                </tr>
                <tr>
                    <td>Name of the Student: </td><td><%= this.name %></td>
                </tr>
                <tr>
                    <td>Date of Birth: </td><td><%= this.date %></td>
                </tr>
                <tr>
                    <td>Contact No.: </td><td><%= this.mobile %></td>
                </tr>
                <tr>
                    <td>Email id: </td><td><%= this.email %></td>
                </tr>
                <tr>
                    <td>Father's Name: </td><td><%= this.father %></td>
                </tr>
                <tr>
                    <td>Mother's Name: </td><td><%= this.mother %></td>
                </tr>
            </table>
        </section>
        
        </div>
    </body>
</html>
