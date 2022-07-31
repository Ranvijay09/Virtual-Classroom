<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%

    String uname = request.getParameter("uname");

    String email = request.getParameter("email");
    String phone_no = request.getParameter("phone_no");
    String pwd = request.getParameter("pwd");
    String utype = request.getParameter("utype");

    Connection con;
    PreparedStatement pst, pst1;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        pst = con.prepareStatement("insert into eduinfo.user(user_email,password,phone_no,role,active) values(?,?,?,?,0)");
        pst.setString(1, email);

        pst.setString(2, pwd);
        pst.setString(3, phone_no);

        pst.setString(4, utype);

        int i = pst.executeUpdate();
        if (i > 0) {

            Statement stmt = con.createStatement();
            String sql = "select user_id from user where user_email = '" + email + "'";

            // execute the statement
            rs = stmt.executeQuery(sql);
            int uid = 0;

            if (rs.next()) {
                uid = rs.getInt("user_id");
                if (utype.equals("S")) {
                    pst1 = con.prepareStatement("insert into eduinfo.student(user_id,student_name) values(?,?)");
                    pst1.setInt(1, uid);

                    pst1.setString(2, uname);
                    
                     pst1.executeUpdate();

                }
                if (utype.equals("T")) {
                    pst1 = con.prepareStatement("insert into eduinfo.teacher(user_id,teacher_name) values(?,?)");
                    pst1.setInt(1, uid);

                    pst1.setString(2, uname);
                   

                     pst1.executeUpdate();

                }

                session.setAttribute("register_msg", "Your registration is successful !");
                response.sendRedirect("register.jsp");
            }

        }
    } catch (Exception e) {
        session.setAttribute("register_msg", e.getMessage().toString());
                response.sendRedirect("register.jsp");
        
    }
%>
