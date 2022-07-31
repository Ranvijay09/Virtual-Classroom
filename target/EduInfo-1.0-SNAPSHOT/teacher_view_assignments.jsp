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
                    <h3 class="text-primary"><i class="fa fa-list-alt"></i> All Assignments </h3><hr>    
                    <div class="row">
                        <div class="modal" id="modalCourseManage">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Assignment Details</h5>
                                    </div>
                                    <div id="editBody">

                                    </div>                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    </div>  
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                             <% if (session.getAttribute("teacher_ea_msg") != null) {%>
                            <div class='alert alert-danger'><strong><%=session.getAttribute("teacher_ea_msg")%></strong> </div>
                                    <% session.setAttribute("teacher_ea_msg", null);
                                        }%>
                            <table id='tab' class="display table table-hover">
                                <thead>
                                    <tr class="table-light">
                                        <th scope="col"> Assignments </th>                                 
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
                                            sql = "select * from assignment join course on assignment.course_id=course.course_id where assignment.teacher_id=" + tid + " order by assignment.asgnmt_id desc";

                                            ResultSet rs = stmt.executeQuery(sql);

                                            while (rs.next()) {
                                    %>
                                    <tr class="table-light">
                                        <td>
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("asgnmt_title")%><span class="h5 pull-right" id="staticBackdropLabel">Course: <%=rs.getString("course_name")%></span></h4>
                                                    <span class="h5">Due By: <%=rs.getString("due_date_time")%></span>

                                                </div>
                                                <div class="modal-body">
                                                    <%=rs.getString("asgnmt_desc")%>
                                                </div>
                                                <div class="modal-footer">   
                                                    <a type="button" data-aid="<%=rs.getInt("asgnmt_id")%>" data-aname="<%=rs.getString("asgnmt_title")%>" data-cid="<%=rs.getInt("course_id")%>" data-adesc="<%=rs.getString("asgnmt_desc")%>" data-adue="<%=rs.getString("due_date_time")%>" onclick="editAsgnmtModal(this)" class="btn btn-success btn-sm">
                                                        Edit Assignment Details
                                                    </a>
                                                    <a type="button" class="btn btn-info btn-sm" href="teacher_view_submissions.jsp?aid=<%=rs.getInt("asgnmt_id")%>&aname=<%=rs.getString("asgnmt_title")%>">View Submissions</a>

                                                    <a type="button" class="btn btn-danger btn-sm" onclick="deleteAsgnmt(<%=rs.getInt("asgnmt_id")%>)">Delete</a>
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

                            function deleteAsgnmt(aid) {
                                $.ajax({
                                    url: 'teacher_del_asgnmt.jsp',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {"aid": aid},
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
                            var modelBody = $("#editBody");
                            function editAsgnmtModal(row) {
                                var aid = row.dataset.aid;
                                var cid = row.dataset.cid;
                                var aname = row.dataset.aname;
                                var adesc = row.dataset.adesc;
                                var adue = row.dataset.adue;
                                $(modelBody).children('div').remove();
                                $(modelBody).append(` <div class="modal-body">
                                <form role="form" action="teacher_edit_assignment2.jsp" method="post">
                                <input name="asgnmt_id" id="asgnmt_id" type="text" value="`+aid+`" hidden>
                                <div class="form-group">
                                    <label for="asgnmt_title" class="text-primary">Assignment Title</label>
                                    <input class="form-control" name="asgnmt_title" id="asgnmt_title" type="text" value="`+aname+`" required>
                                </div>
                                <div class="form-group">
                                    <label class="control-label text-primary"  for="course">Course</label>
                                    <select id="course" name="course" required class="form-control">
                                        <option value="" disabled>Select Course</option>
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
                                    <label for="asgnmt_desc" class="text-primary">Assignment Description</label>
                                    <textarea rows="6" cols="100" class="form-control" id="asgnmt_desc" name="asgnmt_desc" required>`+adesc+`</textarea>
                                </div>
                                    <div class="form-group">
                                        <label for="duetime" class="text-primary">Due Date Time</label>
                                        <input class="form-control" id="duetime" name="duetime" type="datetime-local" value="`+adue+`" required>
                                    </div>

                                <input class="btn btn-primary form-control" name="submit" type="submit" value="Update">
                            </form>
                                </div>  `);
                                $('#course').val(cid);
                                $('#modalCourseManage').modal('show');
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