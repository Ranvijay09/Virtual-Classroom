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
                    <h3 class="text-primary"><i class="fa fa-list-alt"></i> All Notes </h3><hr>    
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
                                            sql = "select * from notes join course on notes.course_id=course.course_id where notes.teacher_id=" + tid + " order by notes.notes_id desc";

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
                                                    <h4 class="modal-title" id="staticBackdropLabel"><%=rs.getString("notes_title")%><span class="h5 pull-right" id="staticBackdropLabel">Course: <%=rs.getString("course_name")%></span></h4>
                                                    
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
                        <script type="text/javascript">
                            
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
                </div>
            </div>
            <hr>

            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>


    </body>

</html>

<%}%>