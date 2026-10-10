<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% if (session.getAttribute("admin") != null) { response.sendRedirect(request.getContextPath() + "/ListStudentServlet"); } else { response.sendRedirect(request.getContextPath() + "/login.jsp"); } %>
