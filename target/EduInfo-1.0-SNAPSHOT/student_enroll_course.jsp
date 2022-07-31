<% if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") != "S")) {
        response.sendRedirect("login.jsp");
    } else {
        int cid=Integer.parseInt(request.getParameter("cid").toString());
        String cname=request.getParameter("cname").toString();
        java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>)(session.getAttribute("student_courses"));
        if(courses.contains(cid))
        {
            response.sendRedirect("student_course_details.jsp?cid="+cid+"&cname="+cname);
        }
%>
<html lang="en">
    <%@include file="head.jsp" %>
    <body>

        <%@include file="student_top_nav.jsp" %>
        <div class="container" style='margin-top:70px'>
            <div class='alert alert-danger'><strong>Welcome <%=session.getAttribute("student_name")%></strong> </div>
            <div class="row">
                <div class="col-sm-3">
                    <%@include file="student_side_nav.jsp" %>
                </div>
                <div class="col-sm-9" >
                    <h3 class="text-primary"><i class="fa fa-unlock-alt"></i> Self Enrollment </h3><hr>    
                    <div class="row col-md-12">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">

                            <% if (session.getAttribute("student_ec_msg") != null) {%>

                            <div class='alert alert-danger'><strong><%=session.getAttribute("student_ec_msg")%></strong> </div>
                                    <% session.setAttribute("student_ec_msg", null);
                                }%>
                            <form role="form" action="student_enroll_course_act.jsp" method="post">
                                <input name="course_id" id="course_id" type="text" value="<%=request.getParameter("cid")%>" hidden="true">
                                
                                <div class="form-group">
                                    <label for="course_name" class="text-primary">Course Name</label>
                                    <input class="form-control" name="course_name" id="course_name" type="text" value="<%=request.getParameter("cname")%>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="passkey" class="text-primary">Enrollment Key</label>
                                    <input class="form-control" id="passkey" name="passkey" type="password" value="" required>
                                </div>


                                <input class="btn btn-primary pull-right" name="submit" type="submit" value="Enrol me">
                            </form>
                        </div>
                        <div class="col-md-2"></div>
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