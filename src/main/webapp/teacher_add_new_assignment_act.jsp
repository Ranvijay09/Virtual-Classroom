<%@page import="java.time.LocalDateTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
    int cid = Integer.parseInt(request.getParameter("course").toString());
    String atitle = request.getParameter("asgnmt_title");
    String adesc = request.getParameter("asgnmt_desc");
    String dtime = request.getParameter("duetime");
    Connection con;
    PreparedStatement pst;
    LocalDateTime ddt = LocalDateTime.parse(dtime);
    LocalDateTime now = LocalDateTime.now();
    if (ddt.isAfter(now)) {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");

            pst = con.prepareStatement("insert into assignment(teacher_id,course_id,asgnmt_title,asgnmt_desc,due_date_time) values(?,?,?,?,?)");
            pst.setInt(1, tid);
            pst.setInt(2, cid);
            pst.setString(3, atitle);
            pst.setString(4, adesc);
            pst.setString(5, dtime);
            int i = pst.executeUpdate();

            if (i > 0) {
                session.setAttribute("teacher_ana_msg", "Assignment added succesfully!");
                response.sendRedirect("teacher_add_new_assignment.jsp");
            }

        } catch (Exception e) {
            session.setAttribute("teacher_ana_msg", e.getMessage().toString());
            response.sendRedirect("teacher_add_new_assignment.jsp");
        }
    } else {
        session.setAttribute("teacher_ana_msg", "Invild Timing!!!");
        response.sendRedirect("teacher_add_new_assignment.jsp");
    }
%>
