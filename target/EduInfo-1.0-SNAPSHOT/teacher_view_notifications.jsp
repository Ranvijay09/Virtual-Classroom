<%@page import="java.util.Base64"%>
<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "T")) {
        response.sendRedirect("login.jsp");
    } else {%>
<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@include file="teacher_top_nav.jsp" %>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("teacher_name")%></strong></div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="teacher_side_nav.jsp" %>
                </div>
                <div class="col-sm-9">
                    <h3 class="text-primary"><i class="fa fa-list-alt"></i> All Notifications </h3><hr>    
                    <div class="row">
                        <div class="col-md-12">
                            <table id='tab' class="display table table-hover">
                                <thead>
                                    <tr class="table-light">
                                        <th scope="col"> Notifications </th>                                 
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                            int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
                                            Statement stmt = con.createStatement();
                                            String sql = "";
                                            sql = "select * from notification join course on notification.course_id=course.course_id where notification.teacher_id=" + tid + " order by notification.msg_id desc";

                                            ResultSet rs = stmt.executeQuery(sql);

                                            while (rs.next()) {
                                    %>
                                    <tr class="table-light">
                                        <td>
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("msg_title")%><span class="h5 pull-right" id="staticBackdropLabel">Course: <%=rs.getString("course_name")%></span></h4>
                                                </div>
                                                <div class="modal-body">
                                                    <%=rs.getString("msg_desc")%>
                                                </div>
                                                <div class="modal-footer">                                                        
                                                    <a type="button" class="btn btn-danger" onclick="deleteNotification(<%=rs.getInt("msg_id")%>)">Delete</a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <% }
                                            con.close();
                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                        <script type="text/javascript">

                            function deleteNotification(mid) {
                                $.ajax({
                                    url: 'teacher_del_msg.jsp',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {"mid": mid},
                                    success: function (data)
                                    {
                                        location.reload(true);
                                    }
                                });
                            }

                            $('#tab').DataTable({
                                "iDisplayLength": 5,
                                "ordering": false
                            });
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