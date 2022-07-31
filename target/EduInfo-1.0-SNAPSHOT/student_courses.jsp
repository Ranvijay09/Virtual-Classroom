<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "S")) {
        response.sendRedirect("login.jsp");
    } else {%>
<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@include file="student_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("student_name")%></strong></div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="student_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >

                    <h3 class="text-primary"><i class="fa fa-book-open"></i> My Enrolled Courses </h3><hr>
                    <div class="row"> 
                        <table id='tab' class="display table text-center table-hover">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col">Enrolled Courses </th>                                 
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                        java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>) (session.getAttribute("student_courses"));
                                        if (!courses.isEmpty()){
                                            String query = "select * from course where course_id in";
                                            String param = "(";
                                            for (int i = 0; i < courses.size(); i++) {
                                                param += "?,";
                                            }
                                            param = param.substring(0, param.length() - 1);
                                            param += ")";
                                            query += param;
                                            PreparedStatement pstmt = con.prepareStatement(query);
                                            for (int i = 0; i < courses.size(); i++) {
                                                pstmt.setInt(i + 1, courses.get(i));
                                            }
                                            ResultSet rs = pstmt.executeQuery();
                                            while (rs.next()) {

                                %>
                                <tr class="table-light">
                                    <td>
                                        <a href="student_course_details.jsp?cid=<%=rs.getInt("course_id")%>&cname=<%=rs.getString("course_name")%>" class="list-group-item list-group-item-action flex-column align-items-start">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1 text-left h4"><%=rs.getString("course_name")%></h5>
                                                <small class="text-muted"></small>
                                            </div>
                                        </a>
                                    </td>
                                </tr>
                                <% }
                                        }

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