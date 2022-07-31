
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

@WebServlet(name = "UploadSbmsn", urlPatterns = {"/UploadSbmsn"})
@MultipartConfig
public class UploadSbmsn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int aid = Integer.parseInt(request.getParameter("asgnmt_id").toString());
        int sid = Integer.parseInt(session.getAttribute("student_id").toString());
        int cid = Integer.parseInt(request.getParameter("course_id").toString());
        String cname = request.getParameter("course_name");
        String dtime = request.getParameter("dtime");
        Part filePart = request.getPart("upfile");
        InputStream pdfFileBytes = null;
        try {
            Connection con = null;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
            Statement stmt = con.createStatement();
            String sql = "select * from submission where asgnmt_id=" + aid + " and student_id = " + sid;
            ResultSet rs = stmt.executeQuery(sql);
            if (!rs.next()) {
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

                PreparedStatement pstmt = con.prepareStatement("insert into eduinfo.submission(course_id,student_id,asgnmt_id,sbmsn_file,submitted_on,sbmsn_marks,eval_status) values(?,?,?,?,?,0,0)");
                pstmt.setInt(1, cid);
                pstmt.setInt(2, sid);
                pstmt.setInt(3, aid);
                pstmt.setBytes(4, bytes);
                pstmt.setString(5, now.toString());

                success = pstmt.executeUpdate();
                if (success >= 1) {
                    session.setAttribute("student_as_msg", "Assignment Submitted Successfully!\nGoto Submissions section to check/update submission.");
                    response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
                }
                con.close();
                if (pdfFileBytes != null) {
                    pdfFileBytes.close();
                }
            } else {
                session.setAttribute("student_as_msg", "Assignment is due!!!");
                response.sendRedirect("student_course_details.jsp?cid=" + cid + "&cname=" + cname);
            }
            }
            else{
                session.setAttribute("student_as_msg", "Assignment Already Submitted!\nGoto Submissions section if you want to update submission.");
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
