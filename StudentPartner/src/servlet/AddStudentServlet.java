package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.StudentDAO;
import model.Student;

/**
 * Servlet to handle adding a new student.
 * Flow: addStudent.jsp -> AddStudentServlet -> StudentDAO.insertStudent() -> ListStudentServlet
 */
@WebServlet(name = "AddStudentServlet", urlPatterns = {"/AddStudentServlet", "/add"})
public class AddStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to add student form page
        request.getRequestDispatcher("addStudent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set character encoding
        request.setCharacterEncoding("UTF-8");

        // Retrieve form fields
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");

        // Simple validation
        if (name != null && email != null && course != null &&
            !name.trim().isEmpty() && !email.trim().isEmpty() && !course.trim().isEmpty()) {

            Student newStudent = new Student(name.trim(), email.trim(), course.trim());
            boolean success = studentDAO.insertStudent(newStudent);

            if (success) {
                // Redirect to student list on success
                response.sendRedirect(request.getContextPath() + "/ListStudentServlet?msg=added");
            } else {
                // Redirect back with error
                response.sendRedirect(request.getContextPath() + "/addStudent.jsp?error=insert_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/addStudent.jsp?error=empty_fields");
        }
    }
}
