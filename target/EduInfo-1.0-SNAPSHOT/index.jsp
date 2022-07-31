<html >
<head>
<style>
#particles-js
{
 background-color: rgb(24, 17, 17);
}
.text {
position: absolute;
top: 50%;
right: 50%;
transform: translate(50%,-50%);
max-width: 90%;
padding: 2em 3em;
background: rgba(0, 0, 0, 0.4);
text-shadow: 0px 0px 2px #131415;
font-family: 'Open Sans', sans-serif;
}

h1 {
font-size: 2.25em;
font-weight: 700;
letter-spacing: -1px;
}
</style>
<link href="css/homestyle.css" rel="stylesheet" type="text/css"/>
</head>
<%@include file="head.jsp" %>
<body style="overflow-x: hidden">
<%@include file="top_nav.jsp" %>

  <section id="particles-js" style="height: 70%">
    <div class="text text-center">
      <h1 style="color: white">EduInfo</h1>
      <h3 style="color: white">Online Learning Management Platform</h3>
  </div>
</section>
	
<script src="js/particles.js"></script>
<script src="js/particles_app.js"></script>
        

        <!-- Page Content -->
        <div class="container">

            <!-- Marketing Icons Section -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header text-primary">
                        EduInfo - Online Learning Management Platform
                    </h1>
        <p> Teachers will be creating courses and add notes, notifications to those courses.
            Students will be enrolling to the courses using the enrollment key given by the
            respective course creator.</p>
        
                </div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h4><i class="fa fa-fw fa-user"></i> User Registration</h4>
                        </div>
                        <div class="panel-body">
                            <a href="register.jsp" class="btn btn-primary">View More</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h4><i class="fa fa-fw fa-user"></i> Who we are</h4>
                        </div>
                        <div class="panel-body">
                            <a href="about.jsp" class="btn btn-primary">View More</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->
            <!-- Features Section -->
<!--            <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header text-primary">Some Major In-corporations :</h2>
                </div>
                <div class="col-md-6">


                    <ul>
                        <li> Images will be used for quiz enrollment keys. </li>
                        <li> Verity of Question Types can be asked in the quiz.</li> 
                        <ul>
                            <li> Multiple Choice Question. </li>
                            <li> Multiple Select Question. </li> 
                            <li> Match the Following. </li>
                            <li> Fill in the Blanks. </li>
                        </ul>
                    </ul>
                </div>
                <div class="col-md-6">
                    <img class="img-responsive" src="images/contact.jpg" alt="">
                </div>
            </div>-->
            <!-- /.row -->

            <hr>

            <!-- Call to Action Section -->
            <div class="well">
                <div class="row">
                    <div class="col-md-8">
                        <p>We expect your loyal feedback to improve our standard.For more details and any subject related queries..</p>
                    </div>
                    <div class="col-md-4">
                        <a class="btn btn-primary btn-block" href="contact.jsp"><i class="fa fa-phone"></i> Call to Action</a>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <img src='' width="100%" height="100%" id='ModalImg'>
                    </div>
                </div>
            </div>

            <hr>

            <!-- Footer -->
            <%@include file="footer.jsp" %>

        </div>
        <!-- /.container -->

        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Script to Activate the Carousel -->
        <script>
            $('.carousel').carousel({
                interval: 5000 //changes the speed
            })

            $(".img-portfolio").click(function () {
                var a = $(this).attr("src");
                $("#ModalImg").attr("src", a);
                $('#myModal').modal();
            })
        </script>

    </body>

</html>
