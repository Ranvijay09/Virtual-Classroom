<%@page import="org.json.simple.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%
    JSONArray list=new JSONArray();
    int subid = Integer.parseInt(request.getParameter("subid").toString());
    int marks = Integer.parseInt(request.getParameter("marks").toString());
    JSONObject obj=new JSONObject();
    Connection con;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();
        int st = 0;
        st = stmt.executeUpdate("update submission set eval_status=1, sbmsn_marks="+marks+" where sbmsn_id=" + subid);
        if (st != 0) {
            obj.put("name","success");
            list.add(obj);
            out.println(list.toJSONString());
            out.flush();
        }
    } catch (Exception e) {
        
    }
%>
