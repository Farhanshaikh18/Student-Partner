package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.StudentDAO;

/**
 * Servlet to handle deleting a student.
 * Flow: studentList.jsp -> DeleteStudentServlet -> StudentDAO.deleteStudent() -> ListStudentServlet
 */
@WebServlet(name = "DeleteStudentServlet", urlPatterns = {"/DeleteStudentServlet", "/delete"})
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Use the student record form to delete a record.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processDelete(request, response);
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                boolean success = studentDAO.deleteStudent(id);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/ListStudentServlet?msg=deleted");
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // On failure
        response.sendRedirect(request.getContextPath() + "/ListStudentServlet?error=delete_failed");
    }
}
