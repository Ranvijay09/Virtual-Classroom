<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
    String cname = request.getParameter("course_name");
    String ekey = request.getParameter("passkey");

    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();
        rs = stmt.executeQuery("select * from course where course_name='" + cname + "'");
        if (rs.next()) {
            session.setAttribute("teacher_ac_msg", "Course name already exists!");
            response.sendRedirect("teacher_add_new_course.jsp");
        } else {
            pst = con.prepareStatement("insert into course(teacher_id,course_name,enrollment_key) values(?,?,?)");
            pst.setInt(1, tid);
            pst.setString(2, cname);
            pst.setString(3, ekey);

            int i = pst.executeUpdate();

            if (i > 0) {
                session.setAttribute("teacher_ac_msg", "Course added succesfully!");
                response.sendRedirect("teacher_add_new_course.jsp");
            }
        }
    } catch (Exception e) {
        session.setAttribute("teacher_ac_msg", e.getMessage().toString());
        response.sendRedirect("teacher_add_new_course.jsp");
    }
%>
