<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "A")) {
        response.sendRedirect("login.jsp");
    } else {%>
<!DOCTYPE html>

<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
        <%
            String n_courses = "", n_students = "", n_teachers = "", n_quizzes = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                Statement stmt = con.createStatement();
                String sql1 = "select count(*) from teacher";
                String sql2 = "select count(*) from student";
                String sql3 = "select count(*) from course";

                // execute the statement
                ResultSet rs1 = stmt.executeQuery(sql1);
                if (rs1.next()) {
                    n_teachers = rs1.getString(1);
                }
                rs1.close();
                ResultSet rs2 = stmt.executeQuery(sql2);
                if (rs2.next()) {
                    n_students = rs2.getString(1);
                }
                rs2.close();
                ResultSet rs3 = stmt.executeQuery(sql3);
                if (rs3.next()) {
                    n_courses = rs3.getString(1);
                }
                rs3.close();
                con.close();
            } catch (Exception e) {
                out.println(e.getMessage());
            }
        %>
        <%@include file="admin_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome Admin</strong> </div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="admin_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >
                    <!--                    <h3 class="text-primary"><i class="fa fa-search"></i> Search Donor Details </h3><hr>    -->
                    <div class="row" style="margin-top: 10%">
                        <div class="col-md-4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4><i class="fa fa-fw fa-user"></i> Total Teachers</h4>
                                </div>
                                <div class="panel-body text-center text-primary">
                                    <h1><%=n_teachers%></h1>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4><i class="fa fa-fw fa-user"></i> Total Students</h4>
                                </div>
                                <div class="panel-body text-center text-primary">
                                    <h1><%=n_students%></h1>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4><i class="fa fa-fw fa-user"></i> Total Courses</h4>
                                </div>
                                <div class="panel-body text-center text-primary">
                                    <h1><%=n_courses%></h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <hr>
            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>

    </body>

</html>

<%
    }%>