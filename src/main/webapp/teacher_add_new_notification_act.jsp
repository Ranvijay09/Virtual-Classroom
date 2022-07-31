<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
    int cid = Integer.parseInt(request.getParameter("course").toString());
    String mtitle = request.getParameter("msg_title");
    String mdesc = request.getParameter("msg_desc");

    Connection con;
    PreparedStatement pst;
    
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();

        pst = con.prepareStatement("insert into notification(teacher_id,course_id,msg_title,msg_desc) values(?,?,?,?)");
        pst.setInt(1, tid);
        pst.setInt(2, cid);
        pst.setString(3, mtitle);
        pst.setString(4, mdesc);
        int i = pst.executeUpdate();

        if (i > 0) {
            
            session.setAttribute("teacher_ano_msg", "Notification added succesfully!");
            response.sendRedirect("teacher_add_new_notification.jsp");
        }

    } catch (Exception e) {
        session.setAttribute("teacher_ano_msg", e.getMessage().toString());
        response.sendRedirect("teacher_add_new_notification.jsp");
    }
%>
