<%@page import="java.util.Base64"%>
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

                    <h3 class="text-primary"><i class="fa fa-bell"></i> All Notifications </h3><hr>
                    <div class="row"> 

                        <table id='tab' class="display table table-hover">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col"> Notifications </th>                                 
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                        java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>) (session.getAttribute("student_courses"));
                                        if (!courses.isEmpty()) {
                                            String query = "select * from notification where course_id in";
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
                                            while (rs.next()) {%>
                                <tr class="table-light">
                                    <td>
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("msg_title")%></h4>
                                            </div>
                                            <div class="modal-body">
                                                <%=rs.getString("msg_desc")%>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <% }
                                        }
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