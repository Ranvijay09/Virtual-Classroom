<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Base64"%>
<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "S")) {
        response.sendRedirect("login.jsp");
    } else {%>
<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <%@include file="student_top_nav.jsp" %>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("student_name")%></strong></div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="student_side_nav.jsp" %>
                </div>
                <div class="col-sm-9">
                    <h3 class="text-primary"><i class="fa fa-info-circle"></i> Course Details </h3><hr>    
                    <h3>Course Name: <%=request.getParameter("cname")%></h3>

                    <div class="row">
                        <% if (session.getAttribute("student_as_msg") != null) {%>

                        <div class='alert alert-danger'><strong><%=session.getAttribute("student_as_msg")%></strong> </div>
                                <% session.setAttribute("student_as_msg", null);
                                    }%>
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
                        <div class="modal" id="modalEditSbmsn">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Submission</h5>
                                    </div>
                                    <div id="editSbmsnBody">

                                    </div>                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    </div>  
                                </div>
                            </div>
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
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="submissions-tab" data-toggle="tab" data-target="#submissions" type="button" role="tab" aria-controls="submissions" aria-selected="false">Submissions</a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="grades-tab" data-toggle="tab" data-target="#grades" type="button" role="tab" aria-controls="grades" aria-selected="false">Grades</a>
                                </li>
                            </ul>

                            <div class="tab-content" style="margin-top: 20px">
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
                                                    int cid = Integer.parseInt(request.getParameter("cid").toString());
                                                    String query = "select * from notes where course_id=" + cid;

                                                    PreparedStatement pstmt = con.prepareStatement(query);

                                                    ResultSet rs = pstmt.executeQuery();
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
                                                    java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>) (session.getAttribute("student_courses"));
                                                    int cid = Integer.parseInt(request.getParameter("cid").toString());
                                                    String query = "select * from notification where course_id=" + cid;

                                                    PreparedStatement pstmt = con.prepareStatement(query);

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
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    Statement stmt = con.createStatement();
                                                    String sql = "";
                                                    sql = "select * from assignment join course on assignment.course_id=course.course_id where assignment.course_id=" + cid + " order by assignment.asgnmt_id desc";
                                                    LocalDateTime now = LocalDateTime.now();
                                                    ResultSet rs = stmt.executeQuery(sql);

                                                    while (rs.next()) {
                                                        String dtime = rs.getString("due_date_time");
                                                        LocalDateTime ddt = LocalDateTime.parse(dtime);

                                                        if (ddt.isAfter(now)) {
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
                                                            <a type="button" data-aid="<%=rs.getInt("asgnmt_id")%>" data-dtime="<%=rs.getString("due_date_time")%>" data-cname="<%=rs.getString("course_name")%>" data-aname="<%=rs.getString("asgnmt_title")%>" data-cid="<%=rs.getInt("course_id")%>" onclick="addSbmsnModal(this)" class="btn btn-success btn-sm">
                                                                Add Submission
                                                            </a>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%          }
                                                    }
                                                    con.close();
                                                } catch (Exception e) {
                                                    out.println(e);
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="submissions" role="tabpanel" aria-labelledby="submissions-tab">
                                    <table id='tab4' class="display table table-hover">
                                        <thead>
                                            <tr class="table-light">
                                                <th scope="col"> Submissions </th>                                 
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
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    int sid = Integer.parseInt(session.getAttribute("student_id").toString());
                                                    Statement stmt = con.createStatement();
                                                    String sql = "";
                                                    sql = "select * from submission join assignment on submission.asgnmt_id=assignment.asgnmt_id where submission.course_id=" + cid + " and submission.student_id=" + sid + " order by submission.sbmsn_id desc";
                                                    LocalDateTime now = LocalDateTime.now();
                                                    ResultSet rs = stmt.executeQuery(sql);

                                                    while (rs.next()) {
                                                        String dtime = rs.getString("due_date_time");
                                                        LocalDateTime ddt = LocalDateTime.parse(dtime);

                                                        b = rs.getBlob("sbmsn_file");
                                                        Data = b.getBytes(1, (int) b.length());
                                                        DataBase64 = new String(Base64.getEncoder().encode(Data));
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
                                                            <a type="button" data-pdf="<%=DataBase64%>" onclick="pdfViewerModal(this)" class="btn btn-info btn-sm">
                                                                View Submission 
                                                            </a>
                                                            <%if (ddt.isAfter(now)) {%>
                                                            <a type="button" data-subid="<%=rs.getInt("sbmsn_id")%>" data-aid="<%=rs.getInt("asgnmt_id")%>" data-dtime="<%=rs.getString("due_date_time")%>" data-cname="<%=request.getParameter("cname")%>" data-aname="<%=rs.getString("asgnmt_title")%>" data-cid="<%=rs.getInt("course_id")%>" onclick="EditSbmsnModal(this)" class="btn btn-success btn-sm">
                                                                Edit Submission
                                                            </a>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%          }

                                                    con.close();
                                                } catch (Exception e) {
                                                    out.println(e);
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="grades" role="tabpanel" aria-labelledby="grades-tab">
                                    <div class="pull-right" id="removelinks">
                                        <button class="btn btn-primary w-100 mb-1" onclick="return createPDF()">Get PDF</button>
                                    </div>

                                    <table id='tab' class="display table table-hover">
                                        <thead>
                                            <tr class="table-light">
                                                <th scope="col"> Sr. No. </th>    
                                                <th> Assignment Title </th> 
                                                <th> Submitted On </th> 
                                                <th> Obtained Marks </th>                                                 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try {
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                                    int sid = Integer.parseInt(session.getAttribute("student_id").toString());
                                                    Statement stmt = con.createStatement();
                                                    String sql = "";
                                                    sql = "select * from submission join assignment on submission.asgnmt_id=assignment.asgnmt_id where submission.eval_status=1 and submission.course_id=" + cid + " and submission.student_id=" + sid + " order by submission.sbmsn_id desc";

                                                    ResultSet rs = stmt.executeQuery(sql);
                                                    int i = 1;
                                                    while (rs.next()) {
                                            %>
                                            <tr class="table-default">
                                                <td scope="row"><%=i++%></td>
                                                <td><%=rs.getString("asgnmt_title")%></td>
                                                <td><%=rs.getString("submitted_on")%></td>
                                                <td><%=rs.getInt("sbmsn_marks")%></td>
                                            </tr>
                                            <%          }

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
                            $('#tab4').DataTable({
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
                            var modelEditSbmsnBody = $("#editSbmsnBody");
                            function EditSbmsnModal(row) {
                                var aid = row.dataset.aid;
                                var cid = row.dataset.cid;
                                var subid = row.dataset.subid;
                                var aname = row.dataset.aname;
                                var cname = row.dataset.cname;
                                var dtime = row.dataset.dtime;
                                $(modelEditSbmsnBody).children('div').remove();
                                $(modelEditSbmsnBody).append(` <div class="modal-body">
                                <form role="form" action="EditSbmsn" method="post" enctype="multipart/form-data">
                                <input name="asgnmt_id" id="asgnmt_id" type="text" value="` + aid + `" hidden>
                                <input name="course_id" id="course_id" type="text" value="` + cid + `" hidden>
                                <input name="subid" id="subid" type="text" value="` + subid + `" hidden>
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
                                $('#modalEditSbmsn').modal('show');
                            }
                            function createPDF() {
                                var sTable = document.getElementById('grades').innerHTML;
                                var style = "<style>";
                                style = style + "table {width: 100%;font: 14px Times-New-Roman;rotate:90}";
                                style = style + "table, th, td {border: solid 2px #DDD; border-collapse: collapse;";
                                style = style + "padding: 3px 3px;text-align: center;}";
                                style = style + "#removeheading{display:none;}";
                                style = style + "#removelinks{display:none;}";
                                style = style + "</style>";

                                //Create Window Object
                                var win = window.open('', '', 'height=1000,width=800');

                                win.document.write('<html><head>');
                                win.document.write('<title></title>');   // <title> FOR PDF HEADER.
                                win.document.write(style);          // ADD STYLE INSIDE THE HEAD TAG.
                                win.document.write('</head>');
                                win.document.write('<body><center><div id="Heading"><h1 id="Report_Heading">Grades Table</h1><hr style="width:40%;"></div></center><br><br>');
                                win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
                                win.document.write('</body></html>');
                                win.document.close(); 	// CLOSE THE CURRENT WINDOW.
                                win.print();    // PRINT THE CONTENTS.
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