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
                    <h3 class="text-primary"><i class="fa fa-user-plus"></i> Add New Admin </h3><hr>    
                    <div class="row" style="padding: 2%">
                        <% if (session.getAttribute("admin_add_msg") != null) {%>

                        <div class='alert alert-danger'><strong><%=session.getAttribute("admin_add_msg")%></strong> </div>
                                <% session.setAttribute("admin_add_msg", null);
                                        }%>
                        <div class="panel panel-primary">
                           
                            <div class="panel-body">
                                <form method="post" action="admin_add_new_admin_act.jsp" autocomplete="off" role="form" >
                                    <div class="form-group">
                                        <label class="control-label text-primary" for="email" >Email ID</label>
                                        <input type="email"  required name="email" id="email" class="form-control" placeholder="Email Address">
                                        <span class="text-primary" id="email_msg"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label text-primary" for="phone_no" >Mobile No.</label>
                                        <input type="mobile" required name="phone_no" id="phone_no" class="form-control" placeholder="Contact No.">
                                        <span class="text-primary" id="phone_no_msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label text-primary" for="pwd" >Password</label>
                                        <input type="password"  required name="pwd" id="pwd" class="form-control" placeholder="Password">
                                        <span class="text-primary" id="pwd_msg"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label text-primary" for="cpwd" >Confirm Password</label>
                                        <input type="password"  required name="cpwd" id="cpwd" class="form-control" placeholder="Confirm Password">
                                        <span class="text-primary" id="cpwd_msg"></span>
                                    </div>
                                    
                                    <div class="form-group text-center w-50">
                                        <input class="btn btn-success" type="submit" name="submit" value="Save">
                                    </div>
                                </form>
                            </div>

                        </div>                       
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
