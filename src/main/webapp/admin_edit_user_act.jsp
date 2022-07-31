<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int uid = Integer.parseInt(request.getParameter("uid"));

    int ustatus = Integer.parseInt(request.getParameter("ustatus"));

    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        pst = con.prepareStatement("update user set active=? where user_id=?");
        pst.setInt(1, ustatus);
        pst.setInt(2, uid);
        int i = pst.executeUpdate();
        if (i > 0) {

            response.sendRedirect("admin_users.jsp");
        }

    } catch (Exception e) {
        response.sendRedirect("admin_users.jsp");
    }
%>
