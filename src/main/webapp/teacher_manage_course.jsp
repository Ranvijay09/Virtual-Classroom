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
                    <h3 class="text-primary"><i class="fa fa-info-circle"></i> Course Details </h3><hr>    
                    <h3>Course Name: <%=request.getParameter("cname")%></h3>

                    <div class="row">
                        <div class="modal" id="modalCourseManage">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">PDF Viewer</h5>
                                    </div>
                                    <div id="editBody">

                                    </div>                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    </div>  
                                </div>
                            </div>
                        </div>
                        <div class="modal" id="modalEditAsgnmt">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Assignment Details</h5>
                                    </div>
                                    <div id="editAsgnmtBody">

                                    </div>                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    </div>  
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <a type="button" href="teacher_add_new_notes.jsp" class="btn btn-info">
                                Add Notes 
                            </a>
                            <a type="button" href="teacher_add_new_notification.jsp" class="btn btn-info">
                                Add Notifications 
                            </a>
                            <!--<button type="button" class="btn btn-info" data-toggle="modal" data-target="#modalAddQuestion">Add New Question</button>-->
                        </div>
                        <div class="form-group col-md-6">
                            <button class="btn btn-danger pull-right" onclick="deleteCourse(<%=request.getParameter("cid")%>)">Delete Course</button>
                        </div>
                        <div class="col-md-12">
                            <ul class="nav nav-tabs nav-fill flex-column flex-sm-row" id="myTab" role="tablist">
                                <li class="nav-item active" role="presentation">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" data-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Notes</a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" data-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Notifications</a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="messages-tab" data-toggle="tab" data-target="#messages" type="button" role="tab" aria-controls="messages" aria-selected="false">Assignments</a>
                                </li>
                            </ul>

                            <div class="tab-content" style="margin-top: 50px">
                                <div class="tab-pane active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                    <table id='tab1' class="display table table-hover">
                                        <thead>
                                            <tr class="table-light">
                                                <th scope="col"> Notes </th>                                 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try {
                                                    Blob b = null;
                                                    byte[] Data = null;

                                                    String DataBase64 = "";
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                                    int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
                                                    Statement stmt = con.createStatement();
                                                    String sql = "";
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    sql = "select * from notes where teacher_id=" + tid + " and course_id=" + cid + " order by notes_id desc";

                                                    ResultSet rs = stmt.executeQuery(sql);

                                                    while (rs.next()) {
                                                        b = rs.getBlob("notes_file");
                                                        Data = b.getBytes(1, (int) b.length());
                                                        DataBase64 = new String(Base64.getEncoder().encode(Data));
                                            %>
                                            <tr class="table-light">
                                                <td>
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("notes_title")%></h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <%=rs.getString("notes_desc")%>
                                                        </div>
                                                        <div class="modal-footer">                                                        
                                                            <a type="button" data-pdf="<%=DataBase64%>" onclick="pdfViewerModal(this)" class="btn btn-success editbtn">
                                                                View Attachment 
                                                            </a>
                                                            <a type="button" class="btn btn-danger" onclick="deleteNotes(<%=rs.getInt("notes_id")%>)">Delete</a>
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

                                <div class="tab-pane" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                    <table id='tab2' class="display table table-hover">
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
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    sql = "select * from notification where teacher_id=" + tid + " and course_id=" + cid + " order by msg_id desc";

                                                    ResultSet rs = stmt.executeQuery(sql);

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

                                <div class="tab-pane" id="messages" role="tabpanel" aria-labelledby="messages-tab">
                                    <table id='tab3' class="display table table-hover">
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
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    Statement stmt = con.createStatement();
                                                    String sql = "";
                                                    sql = "select * from assignment join course on assignment.course_id=course.course_id where assignment.teacher_id=" + tid + " and assignment.course_id=" + cid + " order by assignment.asgnmt_id desc";

                                                    ResultSet rs = stmt.executeQuery(sql);

                                                    while (rs.next()) {
                                            %>
                                            <tr class="table-light">
                                                <td>
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("asgnmt_title")%></h4>
                                                            <span class="h5">Due By: <%=rs.getString("due_date_time")%></span>

                                                        </div>
                                                        <div class="modal-body">
                                                            <%=rs.getString("asgnmt_desc")%>
                                                        </div>
                                                        <div class="modal-footer">   
                                                            <a type="button" data-aid="<%=rs.getInt("asgnmt_id")%>" data-aname="<%=rs.getString("asgnmt_title")%>" data-cname="<%=rs.getString("course_name")%>" data-cid="<%=rs.getInt("course_id")%>" data-adesc="<%=rs.getString("asgnmt_desc")%>" data-adue="<%=rs.getString("due_date_time")%>" onclick="editAsgnmtModal(this)" class="btn btn-success btn-sm">
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
                            </div>
                        </div>
                        <script type="text/javascript">
                            $('#myTab a').click(function (e) {
                                e.preventDefault();
                                $(this).tab('show');
                            });
                            function deleteNotes(nid) {
                                $.ajax({
                                    url: 'teacher_del_notes.jsp',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {"nid": nid},
                                    success: function (data)
                                    {
                                        location.reload(true);
                                    }
                                });
                            }
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

                            $('#tab1').DataTable({
                                "iDisplayLength": 5,
                                "ordering": false
                            });
                            $('#tab2').DataTable({
                                "iDisplayLength": 5,
                                "ordering": false
                            });
                            $('#tab3').DataTable({
                                "iDisplayLength": 5,
                                "ordering": false
                            });

                            var modelBody = $("#editBody");
                            function pdfViewerModal(row) {
                                var d = row.dataset.pdf;
                                $(modelBody).children('div').remove();
                                $(modelBody).append(` <div class="modal-body">
                                <embed type="application/pdf" src="data:application/pdf;base64,` + d + `" frameborder="0" style="width:100%;height:500px;"></embed>
                             
                                </div>  `);
                                $('#modalCourseManage').modal('show');
                            }

                            function deleteCourse(cid) {
                                url = 'teacher_del_course.jsp?cid=' + cid;
                                var r = confirm("Are You sure, you want to delete this course, \nEvery data related to this course will be deleted. \n Notes \n Messages \n Assignments \n Submissions");
                                if (r === true) {
                                    window.location.href = url; //"/student/Home";
                                }
                            }

                            var modelAsgnmtBody = $("#editAsgnmtBody");
                            function editAsgnmtModal(row) {
                                var aid = row.dataset.aid;
                                var cid = row.dataset.cid;
                                var cname = row.dataset.cname;
                                var aname = row.dataset.aname;
                                var adesc = row.dataset.adesc;
                                var adue = row.dataset.adue;
                                $(modelAsgnmtBody).children('div').remove();
                                $(modelAsgnmtBody).append(` <div class="modal-body">
                                <form role="form" action="teacher_edit_assignment1.jsp" method="post">
                                <input name="asgnmt_id" id="asgnmt_id" type="text" value="` + aid + `" hidden>
                                <input name="cname" id="cname" type="text" value="` + cname + `" hidden>
                                <div class="form-group">
                                    <label for="asgnmt_title" class="text-primary">Assignment Title</label>
                                    <input class="form-control" name="asgnmt_title" id="asgnmt_title" type="text" value="` + aname + `" required>
                                </div>
                                    <select id="course" name="course" hidden>
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
                                   
                                <div class="form-group">
                                    <label for="asgnmt_desc" class="text-primary">Assignment Description</label>
                                    <textarea rows="6" cols="100" class="form-control" id="asgnmt_desc" name="asgnmt_desc" required>` + adesc + `</textarea>
                                </div>
                                    <div class="form-group">
                                        <label for="duetime" class="text-primary">Due Date Time</label>
                                        <input class="form-control" id="duetime" name="duetime" type="datetime-local" value="` + adue + `" required>
                                    </div>

                                <input class="btn btn-primary form-control" name="submit" type="submit" value="Update">
                            </form>
                                </div>  `);
                                $('#course').val(cid);
                                $('#modalEditAsgnmt').modal('show');
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