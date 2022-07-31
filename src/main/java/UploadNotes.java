
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

@WebServlet(name = "UploadNotes", urlPatterns = {"/UploadNotes"})
@MultipartConfig
public class UploadNotes extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int tid = Integer.parseInt(session.getAttribute("teacher_id").toString());
        int cid = Integer.parseInt(request.getParameter("course").toString());
        String ntitle = request.getParameter("notes_title");

        String ndesc = request.getParameter("notes_desc");
        Part filePart = request.getPart("upfile");
        InputStream pdfFileBytes = null;

        try {

            if (!filePart.getContentType().equals("application/pdf")) {
                session.setAttribute("teacher_an_msg", "Invalid File!");
                response.sendRedirect("teacher_add_new_notes.jsp");
                return;
            } else if (filePart.getSize() > 1048576) { //2mb
                {
                    session.setAttribute("teacher_an_msg", "File Size Too Big!");
                    response.sendRedirect("teacher_add_new_notes.jsp");
                    return;
                }
            }

            pdfFileBytes = filePart.getInputStream();  // to get the body of the request as binary data

            final byte[] bytes = new byte[pdfFileBytes.available()];
            pdfFileBytes.read(bytes);  //Storing the binary data in bytes array.

            Connection con = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eduinfo", "root", "");
            } catch (Exception e) {
                session.setAttribute("teacher_an_msg", e.getMessage().toString());
                response.sendRedirect("teacher_add_new_notes.jsp");
            }
            int success = 0;

            PreparedStatement pstmt = con.prepareStatement("insert into eduinfo.notes(course_id,teacher_id,notes_title,notes_desc,notes_file) values(?,?,?,?,?)");
            pstmt.setInt(1, cid);
            pstmt.setInt(2, tid);
            pstmt.setString(3, ntitle);
            pstmt.setString(4, ndesc);
            pstmt.setBytes(5, bytes);

            success = pstmt.executeUpdate();
            if (success >= 1) {
                session.setAttribute("teacher_an_msg", "Notes Saved Successfully!");
                response.sendRedirect("teacher_add_new_notes.jsp");
            }
            con.close();
            if (pdfFileBytes != null) {
                pdfFileBytes.close();
            }
        } catch (FileNotFoundException fnf) {
            session.setAttribute("teacher_an_msg", fnf.getMessage().toString());
            response.sendRedirect("teacher_add_new_notes.jsp");
        } catch (SQLException e) {
            session.setAttribute("teacher_an_msg", e.getMessage().toString());
            response.sendRedirect("teacher_add_new_notes.jsp");
        }
    }

}
