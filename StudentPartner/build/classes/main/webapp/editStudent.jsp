<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Student" %>
<%@ page import="dao.StudentDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Student Management System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

    <!-- Top Navigation Bar -->
    <nav class="navbar">
        <a href="<%= request.getContextPath() %>/index.jsp" class="brand">
            🎓 <span>Student</span>Management
        </a>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/ListStudentServlet">View Students</a></li>
            <li><a href="<%= request.getContextPath() %>/addStudent.jsp" class="nav-btn">+ Add Student</a></li>
        </ul>
    </nav>

    <!-- Main Container -->
    <div class="container">

        <%
            // Retrieve Student object from request attribute or direct parameter
            Student student = (Student) request.getAttribute("student");

            // If not found in request attribute, fetch directly via id parameter
            if (student == null) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idParam.trim());
                        StudentDAO dao = new StudentDAO();
                        student = dao.getStudentById(id);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }

            if (student == null) {
        %>
            <!-- Error state if student is not found -->
            <div class="card empty-state">
                <h3>⚠️ Student Record Not Found</h3>
                <p>The student ID requested does not exist or was deleted.</p>
                <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-primary">Return to Student List</a>
            </div>
        <%
            } else {
        %>

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>Edit Student Record</h1>
                <p>Modify the details for student ID: <strong>#<%= student.getId() %></strong></p>
            </div>
            <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-secondary">← Back to Student List</a>
        </div>

        <!-- Form Card -->
        <div class="card form-container">
            <form action="<%= request.getContextPath() %>/UpdateStudentServlet" method="POST">
                
                <!-- Hidden Student ID -->
                <input type="hidden" name="id" value="<%= student.getId() %>">

                <div class="form-group">
                    <label for="id_display">Student ID</label>
                    <input type="text" id="id_display" class="form-control" 
                           value="<%= student.getId() %>" disabled style="background-color: #f1f5f9; cursor: not-allowed;">
                </div>

                <div class="form-group">
                    <label for="name">Full Name <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="name" name="name" class="form-control" 
                           value="<%= student.getName() != null ? student.getName() : "" %>" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="email">Email Address <span style="color: #ef4444;">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="<%= student.getEmail() != null ? student.getEmail() : "" %>" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="course">Enrolled Course <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="course" name="course" list="courseSuggestions" class="form-control" 
                           value="<%= student.getCourse() != null ? student.getCourse() : "" %>" required maxlength="100">
                    <datalist id="courseSuggestions">
                        <option value="Computer Science">
                        <option value="Information Technology">
                        <option value="Data Science & AI">
                        <option value="Software Engineering">
                        <option value="Electrical Engineering">
                        <option value="Business Administration">
                    </datalist>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">🔄 Update Student</button>
                    <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-secondary">Cancel</a>
                </div>

            </form>
        </div>

        <%
            }
        %>

    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; <%= java.time.Year.now().getValue() %> Student Management System. Built with Java EE, JSP, Servlet & MySQL.</p>
    </footer>

</body>
</html>
