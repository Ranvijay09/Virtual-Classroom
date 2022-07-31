<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "A")) {
        response.sendRedirect("login.jsp");
    } else {%>
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
                    <h3 class="text-primary"><i class="fa fa-users"></i> All Users </h3><hr>    
                    <div class="row">
                        <div class="modal" id="modaledituser">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit User Details</h5>
                                    </div>
                                    <div id="editBody">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <table id='tab' class="display table text-center table-hover">
                            <thead>
                                <tr class="table-default">
                                    <th scope="col"> Sr.No </th>
                                    <th scope="col">User ID</th>
                                    <th scope="col">Email ID</th>
                                    <th scope="col">Mobile No.</th>
                                    <th scope="col">Password</th>
                                    <th scope="col">Role</th>
                                    <th scope="col">Account Status</th>
                                    <th scope="col"> Edit </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");

                                        Statement stmt = con.createStatement();
                                        String sql = "select * from user";
                                        ResultSet rs = stmt.executeQuery(sql);
                                        int i = 1;
                                        while (rs.next()) {%>
                                <tr class="table-default t1">
                                    <td scope="row"> <%=i++%></td>
                                    <td><%=rs.getInt("user_id")%></td>
                                    <td><%=rs.getString("user_email")%></td>
                                    <td><%=rs.getString("phone_no")%></td>
                                    <td><%=rs.getString("password")%></td>
                                    <td><%=rs.getString("role")%></td>

                                    <td>
                                        <%if (rs.getInt("active") == 1) {%>
                                        Active
                                        <%} else {%>
                                        Blocked
                                        <%}%>
                                    </td>

                                    <td>
                                        <a type="button" data-uid="<%=rs.getInt("user_id")%>" data-uemail="<%=rs.getString("user_email")%>" data-ustatus="<%=rs.getInt("active")%>" onclick="ShowEditModel(this)" class="btn btn-primary btn-sm">
                                            Edit 
                                        </a>
                                    </td>

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
                            var modelBody = $("#editBody");
                            function ShowEditModel(row) {
                                var uid = row.dataset.uid;
                                var uemail = row.dataset.uemail;
                                var st = row.dataset.ustatus;
                                $(modelBody).children('div').remove();
                                $(modelBody).append(` <div class="modal-body">
                                <form action="admin_edit_user_act.jsp" method="POST" >
                                <fieldset>
                                <legend> User Details </legend>
                                <div class="form-group row">
                                  <label for="user_id" class="col-sm-2 col-form-label"> User ID : </label>
                                  <div class="col-sm-10">
                                    <input type="text" readonly="" class="form-control" name="uid" value="` + uid + `">
                                  </div>
                                </div>
                                <div class="form-group row">
                                  <label for="user_id" class="col-sm-2 col-form-label"> User Email : </label>
                                  <div class="col-sm-10">
                                    <input type="text" readonly="" class="form-control" name="uemail" value="` + uemail + `">
                                  </div>
                                </div>
                                <div class="form-group">
                                  <label class="control-label text-primary"  for="ustatus">Status</label>
                                            <select id="ustatus" name="ustatus" required class="form-control">

                                                <option value="1">Activate</option>
                                                <option value="0">Deactivate</option>

                                            </select>
                                </div>

                                <div class="modal-footer">
                                      <input type="submit" class="btn btn-primary" value="Update"> 
                                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                                </fieldset>
                                </form>
                                </div>   `);
                                $('#ustatus').val(st);
                                $('#modaledituser').modal('show');
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
