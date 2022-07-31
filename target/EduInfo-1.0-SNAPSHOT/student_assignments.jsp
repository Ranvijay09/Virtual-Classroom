<%@page import="java.time.LocalDateTime"%>
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

                    <h3 class="text-primary"><i class="fa fa-bell"></i> All Assignments </h3><hr>
                    <div class="row"> 
                        <div class="modal" id="modalAddSbmsn">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Add Submission</h5>
                                    </div>
                                    <div id="addSbmsnBody">

                                    </div>                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    </div>  
                                </div>
                            </div>
                        </div>
                        <table id='tab' class="display table table-hover">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col"> Assignments </th>                                 
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
                                            String query = "select * from assignment join course on assignment.course_id=course.course_id where assignment.course_id in";
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

                                            LocalDateTime now = LocalDateTime.now();
                                            ResultSet rs = pstmt.executeQuery();
                                            while (rs.next()) {
                                                String dtime = rs.getString("due_date_time");
                                                LocalDateTime ddt = LocalDateTime.parse(dtime);

                                                if (ddt.isAfter(now)) {
                                %>
                                <tr class="table-light">
                                    <td>
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("asgnmt_title")%><span class="h5 pull-right">Course: <%=rs.getString("course_name")%></span></h4>
                                                <span class="h5">Due By: <%=rs.getString("due_date_time")%></span>

                                            </div>
                                            <div class="modal-body">
                                                <%=rs.getString("asgnmt_desc")%>
                                            </div>
                                            <div class="modal-footer">   
                                                <a type="button" data-aid="<%=rs.getInt("asgnmt_id")%>" data-dtime="<%=rs.getString("due_date_time")%>" data-cname="<%=rs.getString("course_name")%>" data-aname="<%=rs.getString("asgnmt_title")%>" data-cid="<%=rs.getInt("course_id")%>" onclick="addSbmsnModal(this)" class="btn btn-success btn-sm">
                                                    Add Submission
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <% }
                                            }
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
                            var modelSbmsnBody = $("#addSbmsnBody");
                            function addSbmsnModal(row) {
                                var aid = row.dataset.aid;
                                var cid = row.dataset.cid;
                                var aname = row.dataset.aname;
                                var cname = row.dataset.cname;
                                var dtime = row.dataset.dtime;
                                $(modelSbmsnBody).children('div').remove();
                                $(modelSbmsnBody).append(` <div class="modal-body">
                                <form role="form" action="UploadSbmsn" method="post" enctype="multipart/form-data">
                                <input name="asgnmt_id" id="asgnmt_id" type="text" value="` + aid + `" hidden>
                                <input name="course_id" id="course_id" type="text" value="` + cid + `" hidden>
                                <input name="dtime" id="dtime" type="text" value="` + dtime + `" hidden>
                                <input name="course_name" id="course_name" type="text" value="` + cname + `" hidden>
                                <div class="form-group">
                                    <label for="asgnmt_title" class="text-primary">Assignment Title</label>
                                    <input class="form-control" name="asgnmt_title" id="asgnmt_title" type="text" value="` + aname + `" required>
                                </div>
                                 <div class="form-group">
                                    <label for="upfile" class="text-primary">Browse File</label>
                                    <input class="form-control" accept="application/pdf" name="upfile" id="upfile" type="file" required>
                                </div>

                                <input class="btn btn-primary form-control" name="submit" type="submit" value="Save">
                                </form>
                                </div>  `);
                                $('#modalAddSbmsn').modal('show');
                            }
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