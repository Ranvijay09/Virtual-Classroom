<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%> 
<%
    // take password for validation
    int cid = Integer.parseInt(request.getParameter("course_id").toString());
    int sid = Integer.parseInt(session.getAttribute("student_id").toString());
    String cname = request.getParameter("course_name");
    String password = request.getParameter("passkey");

    try {
        // register the driver
        Class.forName("com.mysql.jdbc.Driver");

        // establish the connection with the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");

        // create a SQL statement
        Statement stmt = con.createStatement();
        String sql = "select * from course where course_id='" + cid + "' and enrollment_key = '" + password + "'";

        // execute the statement
        ResultSet rs = stmt.executeQuery(sql);
        PreparedStatement pst;
        if (rs.next()) {
            pst = con.prepareStatement("insert into enrollment_course(course_id,student_id) values(?,?)");
            pst.setInt(1, cid);
            pst.setInt(2, sid);
            int i = pst.executeUpdate();

            if (i > 0) {
                java.util.ArrayList<Integer> courses = (java.util.ArrayList<Integer>) (session.getAttribute("student_courses"));
                courses.add(cid);
                session.setAttribute("student_courses", courses);
                response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
            }

            rs.close();;
            con.close();
        } // if password is wrong, display error message
        else {
            session.setAttribute("student_ec_msg", "Incorrect Enrollment Key");
            response.sendRedirect("student_enroll_course.jsp?cid=" + cid + "&cname=" + cname);
        }

        con.close();
    } catch (Exception e) {
        session.setAttribute("student_ec_msg", e.getMessage().toString());
        response.sendRedirect("student_enroll_course.jsp?cid=" + cid + "&cname=" + cname);
    }
%>