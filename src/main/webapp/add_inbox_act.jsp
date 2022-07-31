<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    String fname = request.getParameter("name");

    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String msg = request.getParameter("message");

    Connection con;
    PreparedStatement pst;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        pst = con.prepareStatement("insert into eduinfo.inbox(full_name,email_id,phone_no,contact_msg) values(?,?,?,?)");
        pst.setString(1, fname);
        pst.setString(2, email);
        pst.setString(3, phone);
        pst.setString(4, msg);

        int i = pst.executeUpdate();
        if (i > 0) {
            session.setAttribute("contact_msg", "Your query is succesfully sent to admin!");
            response.sendRedirect("contact.jsp");

        }
    } catch (Exception e) {
        session.setAttribute("contact_msg", e.getMessage().toString());
        response.sendRedirect("contact.jsp");
    }
%>
