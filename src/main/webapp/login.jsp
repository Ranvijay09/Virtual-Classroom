<!DOCTYPE html>

<html lang="en">
    <%@include file="head.jsp" %>
    <body>

        <%@include file="top_nav.jsp" %>
        <!-- Page Content -->
        <div class="container" style="margin-top:70px;">

            <!-- Page Heading/Breadcrumbs -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header text-primary"><i class='fa fa-sign-in'></i>&nbsp;Login</h1>

                </div>
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        
                         <% if (session.getAttribute("login_msg") != null) {%>

                    <div class='alert alert-danger'><strong><%=session.getAttribute("login_msg")%></strong> </div>
                            <% session.setAttribute("login_msg", null);
                        }%>
                        <form role="form" action="login_act.jsp" method="post">
                            <div class="form-group">
                                <label for="user_name" class="text-primary">Email ID</label>
                                <input class="form-control" name="email"  id="email" type="text" required>
                            </div>
                            <div class="form-group">
                                <label for="pass" class="text-primary">Password</label>
                                <input class="form-control" id="pass" name="pass" type="password" value="" required>
                            </div>


                            <input class="btn btn-primary pull-right" name="submit" type="submit" value="Login">
                        </form>
                    </div>
                    <div class="col-md-3"></div>
                </div>

                <hr>
                <%@include file="footer.jsp" %>

            </div>
            <!-- /.container -->

            <!-- jQuery -->
            <script src="js/jquery.js"></script>

            <!-- Bootstrap Core JavaScript -->
            <script src="js/bootstrap.min.js"></script>

    </body>

</html>
