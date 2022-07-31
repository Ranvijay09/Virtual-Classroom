<%
    session.setAttribute("user_id", null);
            
session.setAttribute("role", null);
session.setAttribute("student_id", null);
session.setAttribute("student_name", null);
session.setAttribute("student_courses", null);
response.sendRedirect("login.jsp");
%>