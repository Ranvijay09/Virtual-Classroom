<%@ page import="java.util.*,javax.mail.*"%>

<%@ page import="javax.mail.internet.*" %>

 <%@ page import ="java.sql.*"%>
<%
        final int cid = Integer.parseInt(request.getParameter("course").toString());
        final String sender = request.getParameter("sender");
        final String to = request.getParameter("to");
        //Creating a result for getting status that messsage is delivered or not!
        String result="";

        final String from = "gadgilmansi1@gmail.com";

        final String pass = "#Manc1511";

        // Creating Properties object
        Properties props = new Properties();

        // Defining properties
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        props.put("mail.transport.protocol", "smtp");

        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");
        
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        props.put("mail.user", from);

        props.put("mail.password", pass);

        // Authorized the Session object.
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

            @Override

            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(from, pass);

            }

        });
        try{
            Class.forName("com.mysql.jdbc.Driver");
           Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo","root","");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select course_name,enrollment_key from eduinfo.course where course_id="+cid);
    if (rs.next()) {
        
        final String cname=rs.getString("course_name").toString();
         final String ekey=rs.getString("enrollment_key").toString();
        // Get recipient's email-ID, message & subject-line from index.html page
        final String messg = "This message is from Prof."+sender+"\n\nCourse Name: "+cname+"\nEnrolment Key: "+ekey+"\n\nThis is system generated mail. Do not reply to this mail.";
        try {

            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            if(to.indexOf(',')>0)
            {
                message.setRecipients(Message.RecipientType.CC,InternetAddress.parse(to)); 
            }
            else
            {
                 message.setRecipient(Message.RecipientType.CC,new InternetAddress(to));           
            }

            // Set Subject: header field
            message.setSubject("EduInfo Course Details");

            // Now set the actual message
            message.setText(messg);

            // Send message
            Transport.send(message);

            result = "Sent";

        } catch (MessagingException mex) {

           result= mex.getMessage().toString();

//            result = "Unsent";

        }
//        PreparedStatement ps;
//        
//                ps = con.prepareStatement("insert into urintimator.mail_details(m_sender ,m_to ,m_sub,m_message,m_status) values (?,?,?,?,?)");
//                ps.setString(1, sender);
//                ps.setString(2, to);
//                ps.setString(3, subject);
//                ps.setString(4, messg);
//                ps.setString(5, result);
//               
//                
//                int i = ps.executeUpdate();
//               
//                ps.close();                
    
    }
    con.close();
        }
        catch(Exception ex){
            
        }
    session.setAttribute("teacher_sm_msg", result);
 response.sendRedirect("teacher_send_mail.jsp");
%>