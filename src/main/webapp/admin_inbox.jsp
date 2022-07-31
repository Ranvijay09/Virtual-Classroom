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
                    <h3 class="text-primary"><i class="fa fa-envelope"></i> Inbox </h3><hr>   
                    <div class="modal" id="modalviewmsg">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Message</h5>
                                </div>
                                <div id="msgBody">

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal"> Close </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id='tab' class="display table text-center table-hover">
                        <thead>
                            <tr class="table-light">
                                <th scope="col"> Messages </th>                                 
                            </tr>
                        </thead>
                        <tbody>
                            <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
                            <%
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");

                                    Statement stmt = con.createStatement();
                                    String sql = "select * from inbox order by contact_id desc";
                                    ResultSet rs = stmt.executeQuery(sql);
                                    int i = 1;
                                        while (rs.next()) {%>
                            <tr class="table-light">
                                <td>
                                    <span class="pull-left">
                                        <b><i class="fa fa-envelope-square"></i>&nbsp;<%=rs.getString("full_name")%></b>: <%=rs.getString("contact_msg").substring(0, 30)%>....
                                    </span>
                                    <span class="pull-right">
                                        <a type="button" data-fname="<%=rs.getString("full_name")%>" data-uemail="<%=rs.getString("email_id")%>" data-phno="<%=rs.getString("phone_no")%>" data-msg="<%=rs.getString("contact_msg")%>" onclick="ShowMsgModel(this)" class="btn btn-primary btn-sm">View More</a>
                                        <a type="button" class="btn btn-danger btn-sm" onclick="deleteMsg(<%=rs.getInt("contact_id")%>)">Delete</a>
                                                
                                    </span>
                                </td>
                            </tr>

                            <% } con.close();
                    

                        } catch (Exception e) {
                            out.println(e);
                        }
                            %>
                        </tbody>
                    </table>
                    <script type="text/javascript">
                        $('#tab').DataTable({
                            "aLengthMenu": [10, 25, 50],
                            "bFilter": false,
                            "ordering": false,
                            "iDisplayLength": 10
                        });
                        function deleteMsg(cid) {
                                $.ajax({
                                    url: 'admin_del_mess.jsp',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {"cid": cid},
                                    success: function (data)
                                    {
                                        location.reload(true);
                                    }
                                });
                            }
                        var modelBody = $("#msgBody");
                        function ShowMsgModel(row) {
                            var fname = row.dataset.fname;
                            var uemail = row.dataset.uemail;
                            var phno = row.dataset.phno;
                            var msg = row.dataset.msg;
                            $(modelBody).children('div').remove();
                            $(modelBody).append(` <div class="modal-body">
                                <form method="post" action="" role="form" >
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Full Name:</label>
                                    <input type="text" class="form-control" name="name" readonly value="` + fname + `">
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Phone Number:</label>
                                    <input type="tel" class="form-control" name="phone" value="` + phno + `" readonly>
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Email Address:</label>
                                    <input type="email" class="form-control" name="email" value="` + uemail + `" readonly>
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Message:</label>
                                    <textarea readonly rows="5" cols="100" class="form-control" name="message" readonly>` + msg + `</textarea>
                                </div>
                            </div>
                            </form>
                                </div>   `);
                            $('#modalviewmsg').modal('show');
                        }
                    </script>
                </div>
            </div>

            <hr>
            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>


    </body>

</html>

