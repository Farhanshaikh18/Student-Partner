package servlet;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.StudentDAO;
import model.Student;

/**
 * Servlet to handle updating a student.
 * Flow: studentList.jsp -> editStudent.jsp -> UpdateStudentServlet -> StudentDAO.updateStudent()
 */
@WebServlet(name = "UpdateStudentServlet", urlPatterns = {"/UpdateStudentServlet", "/update"})
public class UpdateStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    /**
     * Handles GET request to fetch existing student data and populate editStudent.jsp
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                Student existingStudent = studentDAO.getStudentById(id);

                if (existingStudent != null) {
                    request.setAttribute("student", existingStudent);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("editStudent.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        // If id is invalid or student not found, redirect back to list
        response.sendRedirect(request.getContextPath() + "/ListStudentServlet?error=not_found");
    }

    /**
     * Handles POST request from editStudent.jsp to update student record in DB
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set character encoding
        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");

        if (idParam != null && name != null && email != null && course != null &&
            !idParam.trim().isEmpty() && !name.trim().isEmpty() && !email.trim().isEmpty() && !course.trim().isEmpty()) {

            try {
                int id = Integer.parseInt(idParam.trim());
                Student updatedStudent = new Student(id, name.trim(), email.trim(), course.trim());
                boolean success = studentDAO.updateStudent(updatedStudent);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/ListStudentServlet?msg=updated");
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // On failure or invalid data
        response.sendRedirect(request.getContextPath() + "/ListStudentServlet?error=update_failed");
    }
}
