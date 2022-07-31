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

                    <h3 class="text-primary"><i class="fa fa-book"></i> All Notes </h3><hr>
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
                        <table id='tab' class="display table table-hover">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col">Notes </th>                                 
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Blob b = null;
                                        byte[] Data = null;

                                        String DataBase64 = "";
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
                                        java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>) (session.getAttribute("student_courses"));
                                        if (!courses.isEmpty()) {
                                            String query = "select * from notes where course_id in";
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