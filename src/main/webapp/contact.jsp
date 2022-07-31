    <!DOCTYPE html>

    <html lang="en">
        <%@include file="head.jsp" %>
        <body>

            <%@include file="top_nav.jsp" %>
            <!-- Page Content -->
            <div class="container" style="margin-top:70px;">

                <div class="row">
                    <div class="col-md-8">
                         <% if (session.getAttribute("contact_msg") != null) {%>

                        <div class='alert alert-danger'><strong><%=session.getAttribute("contact_msg")%></strong> </div>
                                <% session.setAttribute("contact_msg", null);
                                        }%>
                        <h3 class='text-primary'>Send us a Message</h3>
                        <form method="post" action="add_inbox_act.jsp" role="form" >
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Full Name:</label>
                                    <input type="text" class="form-control" pattern="[A-Z a-z]{2,}\s{1}[A-Z a-z]{3,}" name="name" id="name" required>
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Phone Number:</label>
                                    <input type="mobile" pattern="[789][0-9]{9}" class="form-control" name="phone" id="phone" required>
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Email Address:</label>
                                    <input type="email" id="email" pattern="[a-z0-9.!#$%&_]+@[a-z0-9]+\.[a-z]{2,4}$" class="form-control" name="email"  >
                                </div>
                            </div>
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label>Message:</label>
                                    <textarea pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{50,500}" rows="5" cols="100" class="form-control" name="message" id="message" required></textarea>
                                </div>
                            </div>
                            <div id="success"></div>
                            <!-- For success/fail messages -->
                            <input type="submit" class="btn btn-primary" value="Send Message"> 
                        </form>

                    </div>

                    <div class="col-md-4">
                        <h3 class='text-primary' style="margin-bottom: 20px">Contact Details</h3>

                        <p style="margin-bottom: 20px" ><i class="fa fa-phone"></i> 
                            02336526418</p>
                        <p style="margin-bottom: 20px"><i class="fa fa-envelope"></i> 
                            <a href="#">eduinfo@gmail.com</a>
                        </p>
                        <p style="margin-bottom: 20px"><i class="fa fa-clock"></i> 
                            24*7</p>
                        <p style="margin-bottom: 20px"><i class="fa fa-globe"></i> 
                            <a href="index.jsp">www.eduinfo.com</a></p>
                        
                    </div>
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
