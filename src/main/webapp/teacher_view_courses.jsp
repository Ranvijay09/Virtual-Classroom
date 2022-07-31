<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "T")) {
        response.sendRedirect("login.jsp");
    } else {%>
<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@include file="teacher_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("teacher_name")%></strong></div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="teacher_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >
                    <div class="row">
                        <div class="col-md-10">
                            <h1>My Courses</h1>
                        </div>
                        <div class="col-md-2" >
                            <a class="btn btn-primary float-right" href="teacher_add_new_course.jsp">Add New Course</a>
                        </div>
                    </div>
                    <hr>
                    <div class="row">

                        <table id='tab' class="display table text-center table-hover">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col"> Courses </th>                                 
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                        int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
                                        Statement stmt = con.createStatement();
                                        String sql = "select * from course where teacher_id="+tid;
                                        ResultSet rs = stmt.executeQuery(sql);
                                        
                                        while (rs.next()) {%>
                                <tr class="table-light">
                                    <td>
                                        <a href="teacher_manage_course.jsp?cid=<%=rs.getInt("course_id")%>&cname=<%=rs.getString("course_name")%>" class="list-group-item list-group-item-action flex-column align-items-start">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1 text-left h4"><%=rs.getString("course_name")%></h5>
                                                <small class="text-muted"></small>
                                            </div>
                                        </a>
                                    </td>
                                </tr>
                                <% }
                                        // close the connection
                                        con.close();
                                    } catch (Exception e) {
                                        out.println(e);
                                    }
                                %>
                            </tbody>
                        </table>

                        <script type="text/javascript">
                            $('#tab').DataTable();

                        </script>
                    </div>
                </div>
            </div>

            <hr>
            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>


    </body>

</html>

<%}%>