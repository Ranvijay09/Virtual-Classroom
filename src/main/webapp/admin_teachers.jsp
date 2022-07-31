<!DOCTYPE html>

<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@include file="admin_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome Admin</strong> </div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="admin_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >
                    <h3 class="text-primary"><i class="fa fa-users"></i> All Teachers </h3><hr>    
                    <div class="row">
                       
                        <table id='tab' class="display table text-center table-hover">
                            <thead>
                                <tr class="table-default">
                                    <th scope="col"> Sr.No.</th>
                                    <th scope="col">Teacher ID</th>
                                    <th scope="col">Teacher Name</th>
                                    <th scope="col">Email ID</th>
                                    <th scope="col">Mobile No.</th>
                                    <th scope="col">Password</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");

                                        Statement stmt = con.createStatement();
                                        String sql = "select * from teacher join user on teacher.user_id=user.user_id";
                                        ResultSet rs = stmt.executeQuery(sql);
                                        int i=1;
                                        while (rs.next()) {%>
                                <tr class="table-default">
                                    <td scope="row"> <%=i++%></td>
                                    <td><%=rs.getInt("teacher_id")%></td>
                                    <td><%=rs.getString("teacher_name")%></td>
                                    <td><%=rs.getString("user_email")%></td>
                                    <td><%=rs.getString("phone_no")%></td>
                                    <td><%=rs.getString("password")%></td>
                                    
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

