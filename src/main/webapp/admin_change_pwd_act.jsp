<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    int uid = Integer.parseInt(session.getAttribute("user_id").toString());
    String current_pwd = request.getParameter("cpwd");
    String new_pwd = request.getParameter("npwd");

    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();
        rs = stmt.executeQuery("select * from user where user_id=" + uid + " and password='" + current_pwd + "'");
        if (rs.next()) {
            pst = con.prepareStatement("update user set password=? where user_id=?");
            pst.setString(1, new_pwd);
            pst.setInt(2, uid);
            int i = pst.executeUpdate();
            if (i > 0) {
                session.setAttribute("admin_pwd_msg", "Password changed succesfully!");
                response.sendRedirect("admin_change_pwd.jsp");
            }
        }
        else
        {
            session.setAttribute("admin_pwd_msg", "You entered wrong current password!");
                response.sendRedirect("admin_change_pwd.jsp");
        }
    } catch (Exception e) {
        session.setAttribute("admin_pwd_msg", e.getMessage().toString());
        response.sendRedirect("admin_change_pwd.jsp");
    }
%>
