<!DOCTYPE html>

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
                    <!--                    <h3 class="text-primary"><i class="fa fa-search"></i> Search Donor Details </h3><hr>    -->
                    
                </div>
            </div>

            <hr>
            <!-- Footer -->
            <%@include file="footer.jsp" %>
        </div>

    </body>

</html>

