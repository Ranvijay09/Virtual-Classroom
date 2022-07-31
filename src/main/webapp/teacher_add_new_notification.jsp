<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "T")) {
        response.sendRedirect("login.jsp");
    } else {%>
<!DOCTYPE html>

<html lang="en">
    <%@include file="head.jsp" %>

    <body>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*,java.util.*"%> 
        <%@include file="teacher_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("teacher_name")%></strong> </div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="teacher_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >
                    <h3 class="text-primary"><i class="fa fa-plus-circle"></i> Add New Notification </h3><hr> 
                    <div class="row col-md-12">
                        <div class="col-md-2"></div>
                        <div class="col-md-8 ">

                            <% if (session.getAttribute("teacher_ano_msg") != null) {%>
                            <div class='alert alert-danger'><strong><%=session.getAttribute("teacher_ano_msg")%></strong> </div>
                                    <% session.setAttribute("teacher_ano_msg", null);
                                        }%>
                            <form role="form" action="teacher_add_new_notification_act.jsp" method="post">
                                <div class="form-group">
                                    <label for="msg_title" class="text-primary">Message Title</label>
                                    <input class="form-control" name="msg_title" id="msg_title" type="text" required>
                                </div>
                                <div class="form-group">
                                    <label class="control-label text-primary"  for="course">Course</label>
                                    <select id="course" name="course" required class="form-control">
                                        <option value="" selected disabled>Select Course</option>

                                        <%
                                            try {
                                                Class.forName("com.mysql.jdbc.Driver");
                                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                                int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
                                                Statement stmt = con.createStatement();
                                                String sql = "select * from course where teacher_id=" + tid;
                                                ResultSet rs = stmt.executeQuery(sql);
                                                while (rs.next()) {%>
                                        <option value="<%=rs.getInt("course_id")%>"><%=rs.getString("course_name")%></option>
                                        <% }
                                                // close the connection
                                                con.close();
                                            } catch (Exception e) {
                                                out.println(e);
                                            }
                                        %>
                                    </select>
                                    <span class="text-primary" id="course_msg"></span>
                                </div>
                                <div class="form-group">
                                    <label for="msg_desc" class="text-primary">Message Description</label>
                                    <textarea rows="6" cols="100" class="form-control" id="msg_desc" name="msg_desc" required maxlength="999" style="resize:none"></textarea>
                                </div>

                                <input class="btn btn-primary pull-right" name="submit" type="submit" value="Save">
                            </form>
                        </div>
                        <div class="col-md-2"></div>
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