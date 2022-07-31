import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EditSbmsn", urlPatterns = {"/EditSbmsn"})
@MultipartConfig
public class EditSbmsn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int aid = Integer.parseInt(request.getParameter("asgnmt_id").toString());
        int sid = Integer.parseInt(session.getAttribute("student_id").toString());
        int cid = Integer.parseInt(request.getParameter("course_id").toString());
        int subid = Integer.parseInt(request.getParameter("subid").toString());
        String cname = request.getParameter("course_name");
        String dtime = request.getParameter("dtime");
        Part filePart = request.getPart("upfile");
        InputStream pdfFileBytes = null;
        try {
            Connection con = null;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
            Statement stmt = con.createStatement();
            String sql = "select eval_status from submission where sbmsn_id = " + subid;
            ResultSet rs = stmt.executeQuery(sql);
            int st = 0;
            if (rs.next()) {
                st = rs.getInt("eval_status");
            }
            if (st==0) {
                LocalDateTime ddt = LocalDateTime.parse(dtime);
                LocalDateTime now = LocalDateTime.now();
                if (ddt.isAfter(now)) {
                    if (filePart.getSize() > 1048576) { //2mb

                        session.setAttribute("student_as_msg", "File Size Too Big!");
                        response.sendRedirect("student_assignments.jsp");
                        return;
                    }

                    pdfFileBytes = filePart.getInputStream();  // to get the body of the request as binary data

                    final byte[] bytes = new byte[pdfFileBytes.available()];
                    pdfFileBytes.read(bytes);

                    int success = 0;

                    PreparedStatement pstmt = con.prepareStatement("update eduinfo.submission set course_id=?,student_id=?,asgnmt_id=?,sbmsn_file=?,submitted_on=? where sbmsn_id=?");
                    pstmt.setInt(1, cid);
                    pstmt.setInt(2, sid);
                    pstmt.setInt(3, aid);
                    pstmt.setBytes(4, bytes);
                    pstmt.setString(5, now.toString());
                    pstmt.setInt(6, subid);
                    success = pstmt.executeUpdate();
                    if (success >= 1) {
                        session.setAttribute("student_as_msg", "Assignment Updated Successfully!");
                        response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
                    }
                    con.close();
                    if (pdfFileBytes != null) {
                        pdfFileBytes.close();
                    }
                } else {
                    session.setAttribute("student_as_msg", "You can't edit submisssion as assignment is already due!!!");
                    response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
                }
            } else {
                session.setAttribute("student_as_msg", "You can't edit submisssion as assignment is already evaluated!!!");
                response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
            }
        } catch (FileNotFoundException fnf) {
            session.setAttribute("student_as_msg", fnf.getMessage().toString());
            response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
        } catch (SQLException e) {
            session.setAttribute("student_as_msg", e.getMessage().toString());
            response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UploadSbmsn.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
