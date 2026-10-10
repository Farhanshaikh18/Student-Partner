package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/admin/login", "/admin/logout"})
public class AdminAuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        if ("/admin/logout".equals(request.getServletPath())) {
            if (request.getSession(false) != null) request.getSession(false).invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?loggedOut=1");
            return;
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if ("admin".equals(username) && "12345".equals(password)) {
            request.getSession(true).setAttribute("admin", "admin");
            response.sendRedirect(request.getContextPath() + "/ListStudentServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
