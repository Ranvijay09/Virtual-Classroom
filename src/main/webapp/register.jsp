<!DOCTYPE html>

<html lang="en">
    <%@include file="head.jsp" %>
    <body>
        <script>
            var check = function () {
                if (document.getElementById("pwd").value === document.getElementById("cpwd").value) {

                    document.getElementById("cpwd_msg").innerHTML = "Password matched!";
                } else {
                    document.getElementById("cpwd_msg").innerHTML = "Password does not match!";
                }
            }
        </script>
        <%@include file="top_nav.jsp" %>
        <div class="container" style='margin-top:20px;'>
            <div class="row">
                <div class="col-md-12">
                    <h3 class=" text-primary">
                        <i class='fa fa-users'></i> New User Registration
                    </h3><hr>
                </div>
            </div>
            <div class="row centered-form ">
                <div class="col-md-8 col-md-offset-2">
                    <% if (session.getAttribute("register_msg") != null) {%>

                    <div class='alert alert-danger'><strong><%=session.getAttribute("register_msg")%></strong> </div>
                            <% session.setAttribute("register_msg", null);
                                }%>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title text-center" style="padding:5px;font-size:16px;font-weight:bold"><span class="fa fa-user "> </span> JOIN AS STUDENT / TEACHER</h3>
                        </div>

                        <div class="panel-body">
                            <form method="post" action="register_act.jsp" autocomplete="off" role="form" >
                                <div class="form-group">
                                    <label class="control-label text-primary" for="uname" >Name*</label>
                                    <input type="text" placeholder="Full Name" pattern="[A-Z a-z]{2,}\s{1}[A-Z a-z]{3,}" id="uname" name="uname"  required class="form-control">
                                    <span class="text-primary" id="uname_msg">e.g. Navin Patil</span>
                                </div>
                                <div class="form-group">
                                    <label class="control-label text-primary" for="email" >Email ID*</label>
                                    <input type="email" pattern="[a-z0-9.!#$%&_]+@[a-z0-9]+\.[a-z]{2,4}$" required name="email" id="email" class="form-control" placeholder="Email Address">
                                    <span class="text-primary" id="email_msg"></span>
                                </div>
                                <div class="form-group">
                                    <label class="control-label text-primary" for="phone_no" >Mobile No.*</label>
                                    <input type="mobile" pattern="[789][0-9]{9}" required name="phone_no" id="phone_no" class="form-control" placeholder="Contact No.">
                                    <span class="text-primary" id="phone_no_msg"></span>
                                </div>

                                <div class="form-group">
                                    <label class="control-label text-primary" for="pwd" >Password*</label>
                                    <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}"  required name="pwd" id="pwd" class="form-control" placeholder="Password">
                                    <span class="text-primary" id="pwd_msg">Password must contains atleast 1 Uppercase, lowercase character, 1 symbol and 1 number and of size 8-15</span>
                                </div>
                                <div class="form-group">
                                    <label class="control-label text-primary" for="cpwd" >Confirm Password*</label>
                                    <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}" required name="cpwd" id="cpwd" onkeyup="check();" class="form-control" placeholder="Confirm Password">
                                    <span class="text-primary" id="cpwd_msg"></span>
                                </div>

                                <div class="form-group text-center">
                                    <div class="col-md-6">
                                        <label class="control-label text-primary"><input type="radio" checked name="utype" value="S">&nbsp; Register As Student </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="control-label text-primary"><input type="radio" name="utype" value="T">&nbsp; Register As Teacher </label>
                                    </div>
                                </div>

                                <div class="form-group text-center">
                                    <input class="btn btn-success" type="submit" name="submit" value="Registar Now">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


            </div>


        </div>    

        <%@include file="footer.jsp" %>

    </body>
</html>