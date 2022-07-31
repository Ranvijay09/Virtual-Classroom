<%
    session.setAttribute("user_id", null);
            
session.setAttribute("role", null);
session.setAttribute("teacher_id", null);
session.setAttribute("teacher_name", null);
response.sendRedirect("login.jsp");
%>