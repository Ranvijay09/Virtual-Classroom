<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    String email = request.getParameter("email");
    String phone_no = request.getParameter("phone_no");
    String pwd = request.getParameter("pwd");
    

    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        pst = con.prepareStatement("insert into eduinfo.user(user_email,password,phone_no,role,active) values(?,?,?,'A',1)");
        pst.setString(1, email);
        pst.setString(2, pwd);
        pst.setString(3, phone_no);

        int i = pst.executeUpdate();
        if (i > 0) {
                session.setAttribute("admin_add_msg", "New admin added!");
                response.sendRedirect("admin_add_new_admin.jsp");
            }

        }
     catch (Exception e) {
        session.setAttribute("admin_add_msg", e.getMessage().toString());
                response.sendRedirect("admin_add_new_admin.jsp");
        
    }
%>
