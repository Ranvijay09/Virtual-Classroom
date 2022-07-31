<%@page import="java.time.LocalDateTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
    int cid = Integer.parseInt(request.getParameter("course").toString());
    int aid = Integer.parseInt(request.getParameter("asgnmt_id").toString());
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

            pst = con.prepareStatement("update assignment set teacher_id=?,course_id=?,asgnmt_title=?,asgnmt_desc=?,due_date_time=? where asgnmt_id=?");
            pst.setInt(1, tid);
            pst.setInt(2, cid);
            pst.setString(3, atitle);
            pst.setString(4, adesc);
            pst.setString(5, dtime);
            pst.setInt(6, aid);
            int i = pst.executeUpdate();

            if (i > 0) {
                session.setAttribute("teacher_ea_msg", "Assignment details updated succesfully!");
                response.sendRedirect("teacher_view_assignments.jsp");
            }

        } catch (Exception e) {
            session.setAttribute("teacher_ea_msg", e.getMessage().toString());
            response.sendRedirect("teacher_view_assignments.jsp");
        }
    } else {
        session.setAttribute("teacher_ea_msg", "Invild Timing!!!");
        response.sendRedirect("teacher_view_assignments.jsp");
    }
%>
