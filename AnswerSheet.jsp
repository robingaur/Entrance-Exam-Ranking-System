<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" session="true" %>

<%!
private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/jee";
private static final String USER = "root";
private static final String PASS = "password";
private String key, student_response;
private int id, physics_correct, chemistry_correct, mathemathics_correct, physics_incorrect;
private int chemistry_incorrect, mathemathics_incorrect;

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
        String sql = "SELECT * FROM answer_key";
        ResultSet rs = stmt.executeQuery(sql);
        rs.next();
        key = rs.getString("key");

        id = Integer.parseInt(request.getSession().getAttribute("application_id").toString());
        sql = "SELECT * FROM student_response where application_id = " + id;
        rs = stmt.executeQuery(sql);
        rs.next();
        student_response = rs.getString("response");
        physics_correct = rs.getInt("physics_correct");
        chemistry_correct = rs.getInt("chemistry_correct");
        mathemathics_correct = rs.getInt("mathemathics_correct");
        physics_incorrect = rs.getInt("physics_incorrect");
        chemistry_incorrect = rs.getInt("chemistry_incorrect");
        mathemathics_incorrect = rs.getInt("mathemathics_incorrect");

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
            <div class="menu_selected"><a href="#">Answer Sheet/Score</a></div>
            <div class="menu"><a href="Rank.jsp">Rank</a></div>
            <div class="menu"><a href="Logout.jsp">Logout</a></div></div>
        </nav>
        <section class="student_detail_section">
            <font style="font-size: 1.6vw;"><center><b>Your Response and Score</b></center></font><br/><br/>
            <div>
                <div class="score_table">
                    <center>
                        <table border='1' bordercolor='white'>
                            <col width='90' />
                            <col width='90' />
                            <col width='90' />
                            <tr><th colspan="3">Physics</th></tr>
                            <tr>
                                <th>S. No.</th><th>YR</th><th>CA</th>
                            </tr>
                            <%
                                for (int i=0; i<50; i++)
                                {
                                    out.println("<tr>");
                                    out.println("<td align='center'>" + (int)(i+1) + "</td>");
                                    if (student_response.charAt(i) == 'N')
                                        out.println("<td align='center'>" + key.charAt(i) +
                                            "</td><td align='center'>-</td>");
                                    else if (student_response.charAt(i) == key.charAt(i))
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: lightgreen\">"
                                                + student_response.charAt(i) + "</td>");
                                    else
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: red\">"
                                                + student_response.charAt(i) + "</td>");
                                    out.println("</tr>");
                                }
                            %>
                            <tr>
                                <td colspan="2" align='center'>Attempt</td><td align='center'><%= physics_correct + physics_incorrect %></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Correct</td><td align='center'><%= physics_correct %></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Score</td><td align='center'><%= 4*physics_correct - physics_incorrect %></td>
                            </tr>
                        </table>
                    </center>
                </div>
                <div class="score_table">
                    <center>
                        <table border='1' bordercolor='white'>
                            <col width='90' />
                            <col width='90' />
                            <col width='90' />
                            <tr><th colspan="3">Chemistry</th></tr>
                            <tr>
                                <th>S. No.</th><th>YR</th><th>CA</th>
                            </tr>
                            <%
                                for (int i=50; i<100; i++)
                                {
                                    out.println("<tr>");
                                    out.println("<td align='center'>" + (int)(i+1) + "</td>");
                                    if (student_response.charAt(i) == 'N')
                                        out.println("<td align='center'>" + key.charAt(i) +
                                            "</td><td align='center'>-</td>");
                                    else if (student_response.charAt(i) == key.charAt(i))
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: lightgreen\">"
                                                + student_response.charAt(i) + "</td>");
                                    else
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: red\">"
                                                + student_response.charAt(i) + "</td>");
                                    out.println("</tr>");
                                }
                            %>
                            <tr>
                                <td colspan="2" align='center'>Attempt</td><td align='center'><%= chemistry_correct + chemistry_incorrect%></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Correct</td><td align='center'><%= chemistry_correct%></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Score</td><td align='center'><%= 4*chemistry_correct - chemistry_incorrect%></td>
                            </tr>
                        </table>
                    </center>
                </div>
                <div class="score_table">
                    <center>
                        <table border='1' bordercolor='white'>
                            <col width='90' />
                            <col width='90' />
                            <col width='90' />
                            <tr><th colspan="3">Mathemathics</th></tr>
                            <tr>
                                <th>S. No.</th><th>YR</th><th>CA</th>
                            </tr>
                            <%
                                for (int i=100; i<150; i++)
                                {
                                    out.println("<tr>");
                                    out.println("<td align='center'>" + (int)(i+1) + "</td>");
                                    if (student_response.charAt(i) == 'N')
                                        out.println("<td align='center'>" + key.charAt(i) +
                                            "</td><td align='center'>-</td>");
                                    else if (student_response.charAt(i) == key.charAt(i))
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: lightgreen\">"
                                                + student_response.charAt(i) + "</td>");
                                    else
                                        out.println("<td align='center'>" + key.charAt(i)
                                                + "</td><td align='center' style=\"color: red\">"
                                                + student_response.charAt(i) + "</td>");
                                    out.println("</tr>");
                                }
                            %>
                            <tr>
                                <td colspan="2" align='center'>Attempt</td><td align='center'><%= mathemathics_correct + mathemathics_incorrect %></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Correct</td><td align='center'><%= mathemathics_correct %></td>
                            </tr>
                            <tr>
                                <td colspan="2" align='center'>Score</td><td align='center'><%= 4*mathemathics_correct - mathemathics_incorrect %></td>
                            </tr>
                        </table>
                    </center>
                </div>
            </div>
        </section>
    </body>
</html>
