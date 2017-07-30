<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" session="false" %>

<%!
    String message = "";
%>

<%!
private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/jee";
private static final String USER = "root";
private static final String PASS = "password";

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

        String sql = "SELECT max(application_id) FROM student_information";
        ResultSet rs = stmt.executeQuery(sql);

        int id = Integer.parseInt(request.getParameter("application_id"));
        rs.next();
        if (id > rs.getInt(1))
        {
            this.message = "Incorrect Application ID";
            response.sendRedirect("index.jsp");
            return;
        }
        sql = "SELECT password FROM student_information where application_id = " + id;
        rs = stmt.executeQuery(sql);
        String password = request.getParameter("password");
        rs.next();
        if (!password.equals(rs.getString(1)))
        {
            this.message = "Incorrect Password";
            response.sendRedirect("index.jsp");
            return;
        }
        rs.close();
        stmt.close();
        conn.close();
        if (request.getSession() != null)
            request.getSession(false).invalidate();
        HttpSession session = request.getSession(true);
        session.setAttribute("application_id", request.getParameter("application_id"));
        session.setAttribute("password", password);
        session.setMaxInactiveInterval(5*30);
        response.sendRedirect("StudentDetails.jsp");
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
    if (request.getMethod().equals("POST"))
    {
        this.DatabaseAccess(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Joint Entrance Exam 2017</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <center><header>Joint Entrance Exam-2017</header></center>
        <section class="leftsection">
            <div class="information">For new Registration, Register here!</div>
            <form method="post" action="RegistrationSuccess.jsp">
                <table class="tableclass">
                    <tr>
                        <td><label>First Name : </label></td>
                        <td><input class="inputfield" name="firstname" type="text" required="required"
                                   maxlength="25"/></td>
                    </tr>
                    <tr>
                        <td><label>Last Name : </label></td>
                        <td><input class="inputfield" name="lastname" type="text" required="required" maxlength="25"/></td>
                    </tr>
                    <tr>
                        <td><label>Date of Birth : </label></td>
                        <td><input class="inputfield" name="dob" type="date" required="required" 
                                   min="1986-01-01" max="2007-12-31"/><br/></td>
                    </tr>
                    <tr>
                        <td><label>Mobile No. : </label></td>
                        <td><input class="inputfield" name="mobile" type="number" required="required"
                                   min='1000000000' max='9999999999'/></td>
                    </tr>
                    <tr>
                        <td><label>E-mail id : </label></td>
                        <td><input class="inputfield" name="email" type="email" required="required"
                                   maxlength="50" /></td>
                    </tr>
                    <tr>
                        <td><label>Father's Name : </label></td>
                        <td><input class="inputfield" name="fathersname" type="text" required="required"
                                   maxlength="25"/></td>
                    </tr>
                    <tr>
                        <td><label>Mother's Name : </label></td>
                        <td><input class="inputfield" name="mothersname" type="text" required="required"
                                   maxlength="25"/></td>
                    </tr>
                    <tr>
                        <td><label>Password : </label></td>
                        <td><input class="inputfield" name="password" type="password" required="required"
                                   minlength="8" maxlength="25"/></td>
                    </tr>
                    <tr>
                        <td><label>Address : </label></td>
                        <td><textarea class="inputfield" name="address" required="required" style="height: 11vh;"></textarea></td>
                    </tr>
                </table>
                <input class="button" type="submit" value="Register" name="register"/>
            </form>
        </section>
        
        <section class="rightsection">
            <div class="information">Already Registered? Login here! </div>
            <div style="color: red;"><center><%= this.message %></center></div>
            <form method="post" action="index.jsp" >
                <table class="tableclass">
                    <tr>
                        <td><label>Application id: </label></td>
                        <td><input class="inputfield" name="application_id" type="number" required="required"
                                   min="100000" max="999999"/></td>
                    </tr>
                    <tr>
                        <td><label>Password : </label></td>
                        <td><input class="inputfield" name="password" type="password" required="required"
                                   minlength="8" maxlength="25"/></td>
                    </tr>
                </table>
                <input class="button" type="submit" value="Login" name="login" />
            </form>            
            <label style="float: right; font-size: 0.9vw; margin-right: 13%"><a href="">Forgot Password? Click here!</a></label>
        </section>
    </body>
</html>
