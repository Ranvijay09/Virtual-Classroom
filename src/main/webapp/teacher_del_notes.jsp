<%@page import="org.json.simple.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%
    JSONArray list=new JSONArray();
    int nid = Integer.parseInt(request.getParameter("nid").toString());
    JSONObject obj=new JSONObject();
    Connection con;
    ResultSet rs;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
        Statement stmt = con.createStatement();
        int st = 0;
        st = stmt.executeUpdate("delete from notes where notes_id=" + nid);
        if (st != 0) {
            obj.put("name","success");
            list.add(obj);
            out.println(list.toJSONString());
            out.flush();
        }
    } catch (Exception e) {
        
    }
%>
