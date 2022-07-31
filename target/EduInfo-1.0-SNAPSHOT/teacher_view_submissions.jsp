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
                    <h3 class="text-primary"><i class="fa fa-file-upload"></i> Assignment Submissions </h3><hr>    
                    <h3>Assignment Title: <%=request.getParameter("aname")%></h3>

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
                        <div class="col-md-12">
                            <table id='tab' class="display table table-hover">
                                <thead>
                                    <tr class="table-light">
                                        <th scope="col">Sr. No. </th>
                                        <th>Student ID </th>                                  
                                        <th>Student Name </th>
                                        <th>Submission File </th>  
                                        <th>Submitted On </th>
                                        <th>Marks </th>
                                        <th>Action </th>
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
                                            int aid = Integer.parseInt(request.getParameter("aid"));
                                            Statement stmt = con.createStatement();
                                            String sql = "";
                                            sql = "select * from submission join student on submission.student_id=student.student_id where submission.asgnmt_id=" + aid + " order by submission.sbmsn_id";

                                            ResultSet rs = stmt.executeQuery(sql);
                                            int i = 1;
                                            while (rs.next()) {
                                                b = rs.getBlob("sbmsn_file");
                                                Data = b.getBytes(1, (int) b.length());
                                                DataBase64 = new String(Base64.getEncoder().encode(Data));
                                    %>
                                    <tr class="table-default">
                                        <td scope="row"> <%=i++%></td>
                                        <td><%=rs.getInt("student_id")%></td>
                                        <td><%=rs.getString("student_name")%></td>
                                        <td><a type="button" data-pdf="<%=DataBase64%>" onclick="pdfViewerModal(this)" class="btn btn-info btn-sm">View Submission</a></td>
                                        <td><%=rs.getString("submitted_on")%></td>
                                        <td><input type="number" min="0" max="10" onkeydown="return false" id="m<%=rs.getInt("sbmsn_id")%>" min="0" max="10" value="<%=rs.getInt("sbmsn_marks")%>"></td>
                                        <td><a type="button" data-subid="<%=rs.getInt("sbmsn_id")%>" onclick="updateMarks(this)" class="btn btn-primary btn-sm">Submit</a></td>
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
                    function updateMarks(row) {
                        var subid = row.dataset.subid;
                        var inid = "m" + subid;
                        var marks = $('#' + inid).val();
                        $.ajax({
                            url: 'teacher_update_marks.jsp',
                            type: 'post',
                            dataType: 'json',
                            data: {"subid": subid, "marks": marks},
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
                    function pdfViewerModal(row) {
                        var d = row.dataset.pdf;
                        $(modelBody).children('div').remove();
                        $(modelBody).append(` <div class="modal-body">
                        <embed type="application/pdf" src="data:application/pdf;base64,` + d + `" frameborder="0" style="width:100%;height:500px;"></embed>
                             
                        </div>  `);
                        $('#modalCourseManage').modal('show');
                    }
                </script>

            </div>

            <hr>

            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>


    </body>

</html>

<%}%>