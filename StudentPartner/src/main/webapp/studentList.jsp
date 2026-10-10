<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="dao.StudentDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Records - Student Management System</title>
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
            <li><a href="<%= request.getContextPath() %>/ListStudentServlet" class="active">View Students</a></li>
            <li><a href="<%= request.getContextPath() %>/addStudent.jsp" class="nav-btn">+ Add Student</a></li>
        </ul>
    </nav>

    <!-- Main Container -->
    <div class="container">

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>Student Records</h1>
                <p>Manage, inspect, edit, and delete enrolled student profiles.</p>
            </div>
            <a href="<%= request.getContextPath() %>/addStudent.jsp" class="btn btn-success">➕ Add New Student</a>
        </div>

        <!-- Success and Error Flash Message Alerts -->
        <%
            String msg = request.getParameter("msg");
            String error = request.getParameter("error");

            if ("added".equals(msg)) {
        %>
            <div class="alert alert-success">
                <span>✅ <strong>Success!</strong> New student record has been added successfully.</span>
            </div>
        <%
            } else if ("updated".equals(msg)) {
        %>
            <div class="alert alert-success">
                <span>✅ <strong>Success!</strong> Student details have been updated successfully.</span>
            </div>
        <%
            } else if ("deleted".equals(msg)) {
        %>
            <div class="alert alert-success">
                <span>🗑️ <strong>Success!</strong> Student record has been deleted successfully.</span>
            </div>
        <%
            }

            if (error != null) {
        %>
            <div class="alert alert-danger">
                <span>⚠️ 
                <%
                    if ("not_found".equals(error)) {
                        out.print("Student record was not found.");
                    } else if ("update_failed".equals(error)) {
                        out.print("Failed to update student record. Please try again.");
                    } else if ("delete_failed".equals(error)) {
                        out.print("Failed to delete student record. Please check database constraints.");
                    } else {
                        out.print("An error occurred during operation.");
                    }
                %>
                </span>
            </div>
        <%
            }
        %>

        <%
            // Retrieve student list from request attribute
            @SuppressWarnings("unchecked")
            List<Student> studentList = (List<Student>) request.getAttribute("studentList");

            // Fallback: If JSP was opened directly without servlet, fetch records from DAO
            if (studentList == null) {
                StudentDAO dao = new StudentDAO();
                studentList = dao.getAllStudents();
            }
        %>

        <!-- Search Bar and Count -->
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" 
                   placeholder="🔍 Search by name, email, or course..." onkeyup="filterStudents()">
            <span style="font-size: 0.9rem; color: #64748b;">
                Total Students: <strong><%= studentList != null ? studentList.size() : 0 %></strong>
            </span>
        </div>

        <!-- Student Records Table Card -->
        <div class="card" style="padding: 0; overflow: hidden;">
            <%
                if (studentList == null || studentList.isEmpty()) {
            %>
                <div class="empty-state">
                    <h3>No Student Records Found</h3>
                    <p>There are currently no students registered in the database.</p>
                    <a href="<%= request.getContextPath() %>/addStudent.jsp" class="btn btn-primary">➕ Add First Student</a>
                </div>
            <%
                } else {
            %>
                <div class="table-wrapper">
                    <table class="custom-table" id="studentTable">
                        <thead>
                            <tr>
                                <th style="width: 80px;">ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Course</th>
                                <th style="width: 180px; text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Student s : studentList) {
                            %>
                            <tr>
                                <td>
                                    <span class="badge-id">#<%= s.getId() %></span>
                                </td>
                                <td>
                                    <strong><%= s.getName() %></strong>
                                </td>
                                <td>
                                    <%= s.getEmail() %>
                                </td>
                                <td>
                                    <span class="badge-course"><%= s.getCourse() %></span>
                                </td>
                                <td style="text-align: center;">
                                    <div class="actions-cell" style="justify-content: center;">
                                        <!-- Edit Action (links to editStudent.jsp) -->
                                        <a href="<%= request.getContextPath() %>/editStudent.jsp?id=<%= s.getId() %>" 
                                           class="btn btn-sm btn-edit" title="Edit Student">
                                            ✏️ Edit
                                        </a>

                                        <!-- Delete Action (links to DeleteStudentServlet) -->
                                        <a href="<%= request.getContextPath() %>/DeleteStudentServlet?id=<%= s.getId() %>" 
                                           class="btn btn-sm btn-delete" 
                                           onclick="return confirm('Are you sure you want to delete <%= s.getName() %> (ID: <%= s.getId() %>)? This action cannot be undone.');"
                                           title="Delete Student">
                                            🗑️ Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            <%
                }
            %>
        </div>

    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; <%= java.time.Year.now().getValue() %> Student Management System. Built with Java EE, JSP, Servlet & MySQL.</p>
    </footer>

    <!-- Instant Client-Side Search Filter Script -->
    <script>
        function filterStudents() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("studentTable");
            if (!table) return;

            var tr = table.getElementsByTagName("tr");

            // Loop through all table rows except header
            for (var i = 1; i < tr.length; i++) {
                var nameCol = tr[i].getElementsByTagName("td")[1];
                var emailCol = tr[i].getElementsByTagName("td")[2];
                var courseCol = tr[i].getElementsByTagName("td")[3];

                if (nameCol || emailCol || courseCol) {
                    var nameText = nameCol ? nameCol.textContent || nameCol.innerText : "";
                    var emailText = emailCol ? emailCol.textContent || emailCol.innerText : "";
                    var courseText = courseCol ? courseCol.textContent || courseCol.innerText : "";

                    if (nameText.toLowerCase().indexOf(filter) > -1 ||
                        emailText.toLowerCase().indexOf(filter) > -1 ||
                        courseText.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>

</body>
</html>
