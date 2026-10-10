<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Student Management System</title>
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
            <li><a href="<%= request.getContextPath() %>/addStudent.jsp" class="active nav-btn">+ Add Student</a></li>
        </ul>
    </nav>

    <!-- Main Container -->
    <div class="container">

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>Add New Student</h1>
                <p>Enter the student details below to create a new database record.</p>
            </div>
            <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-secondary">← Back to Student List</a>
        </div>

        <!-- Error Notification Alert if applicable -->
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="alert alert-danger">
                <span>⚠️ 
                <%
                    if ("empty_fields".equals(error)) {
                        out.print("All fields are required! Please fill in all the details.");
                    } else if ("insert_failed".equals(error)) {
                        out.print("Failed to save student record to database. Please check database connectivity.");
                    } else {
                        out.print("An unexpected error occurred. Please try again.");
                    }
                %>
                </span>
            </div>
        <%
            }
        %>

        <!-- Form Card -->
        <div class="card form-container">
            <form action="<%= request.getContextPath() %>/AddStudentServlet" method="POST">
                
                <div class="form-group">
                    <label for="name">Full Name <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="name" name="name" class="form-control" 
                           placeholder="e.g. John Doe" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="email">Email Address <span style="color: #ef4444;">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="e.g. john.doe@university.edu" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="course">Enrolled Course <span style="color: #ef4444;">*</span></label>
                    <input type="text" id="course" name="course" list="courseSuggestions" class="form-control" 
                           placeholder="e.g. Computer Science" required maxlength="100">
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
                    <button type="submit" class="btn btn-primary">💾 Save Student</button>
                    <button type="reset" class="btn btn-outline">Clear</button>
                    <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-secondary">Cancel</a>
                </div>

            </form>
        </div>

    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; <%= java.time.Year.now().getValue() %> Student Management System. Built with Java EE, JSP, Servlet & MySQL.</p>
    </footer>

</body>
</html>
