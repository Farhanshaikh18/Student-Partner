<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System - Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

    <!-- Top Navigation Bar -->
    <nav class="navbar">
        <a href="<%= request.getContextPath() %>/index.jsp" class="brand">
            🎓 <span>Student</span>Management
        </a>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/index.jsp" class="active">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/ListStudentServlet">View Students</a></li>
            <li><a href="<%= request.getContextPath() %>/addStudent.jsp" class="nav-btn">+ Add Student</a></li>
        </ul>
    </nav>

    <!-- Main Container -->
    <div class="container">

        <!-- Hero Section -->
        <div class="hero">
            <h1>Student Management System</h1>
            <p>A pure Java EE web application with Servlet, JSP, JDBC, and MySQL. Simple, robust, and designed for academic excellence.</p>
            <div class="hero-actions">
                <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-primary">📋 View All Students</a>
                <a href="<%= request.getContextPath() %>/addStudent.jsp" class="btn btn-success">➕ Add New Student</a>
            </div>
        </div>

        <!-- Quick Features & System Highlights -->
        <div class="features-grid">
            <div class="feature-box">
                <h3>👥 Manage Students</h3>
                <p>View complete records of all enrolled students, inspect their course details, and manage records in real time.</p>
                <a href="<%= request.getContextPath() %>/ListStudentServlet" class="btn btn-sm btn-outline">Explore Records →</a>
            </div>

            <div class="feature-box">
                <h3>📝 Add New Admission</h3>
                <p>Register new student profiles directly with instant validation and secure persistence to the MySQL database.</p>
                <a href="<%= request.getContextPath() %>/addStudent.jsp" class="btn btn-sm btn-outline">Register Student →</a>
            </div>

            <div class="feature-box">
                <h3>⚡ Pure Java EE Stack</h3>
                <p>Zero external frameworks. Built strictly using vanilla Java, JDBC PreparedStatement, HttpServlet, and standard JSP.</p>
                <span class="badge-course">Academic Grade</span>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; <%= java.time.Year.now().getValue() %> Student Management System. Built with Java EE, JSP, Servlet & MySQL.</p>
    </footer>

</body>
</html>
