/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Files;
import Models.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author longnguyen
 */
@MultipartConfig
public class UploadController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                      throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                      throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                      throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("user_id");
        // Get user info
        User user = new User();
        ResultSet rs = user.findById(userId);
        String email = "";
        PrintWriter out = response.getWriter();
        try {
            while(rs.next()) {
                email = rs.getString("email");
            }
            //Init path upload
            String pathUpload = "uploads" + File.separator + email.substring(0, email.indexOf('@'));
            // Get path file upload
            String applicationPath = request.getServletContext().getRealPath("");
            // Path save to file
            String uploadFilePath = applicationPath + pathUpload;
            // Check folder already exit's
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                // Create new folders
                uploadDir.mkdirs();
            }
            // Upload process
            for (Part part : request.getParts()) {
                // Init file name
                String fileName = null;
                // Check enctype upload
                String contentDisposition = part.getHeader("content-disposition");
                // Take file and set filename
                if (contentDisposition != null && contentDisposition.contains("filename")) {
                    fileName = contentDisposition.substring(
                        contentDisposition.lastIndexOf("=") + 2,
                        contentDisposition.length() - 1
                    );
                }
                // Save file
                if (fileName != null && !fileName.isEmpty()) {
                   part.write(uploadFilePath + File.separator + fileName);
                   Files newFile = new Files(); 
                   newFile.store(fileName, part.getSize(), userId);
                }
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp");
            return;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
