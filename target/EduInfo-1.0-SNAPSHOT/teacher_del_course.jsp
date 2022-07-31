<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int cid = Integer.parseInt(request.getParameter("cid").toString());

    Connection con;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();
        int st = 0;
        st = stmt.executeUpdate("delete from course where course_id=" + cid);
        if (st != 0) {
            session.setAttribute("teacher_ac_msg", "Course Data Deleted!");
            response.sendRedirect("teacher_add_new_course.jsp");
        } else {
            session.setAttribute("teacher_ac_msg", "Something Went Wrong!!!");
            response.sendRedirect("teacher_add_new_course.jsp");
        }
    } catch (Exception e) {
        session.setAttribute("teacher_ac_msg", e.getMessage().toString());
        response.sendRedirect("teacher_add_new_course.jsp");
    }
%>
