<%@page import="com.cashify.servlet_cashify_project.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User-home</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8f9fa;
}

.profile-card {
	max-width: 600px;
	margin: 50px auto;
	padding: 30px;
	border-radius: 15px;
	background: #fff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.profile-card img {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 15px;
	border: 3px solid #0d6efd;
}
</style>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>

	<%
User user = (User) session.getAttribute("loggedInUser");
    String joinedDateFormatted = "";
    if (user != null && user.getJoinedDate() != null) {
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy");
        joinedDateFormatted = user.getJoinedDate().format(formatter);
    }
%>

	<div class="profile-card">
		<img src="./images/avtar.jpg" alt="User Profile">
		<h2 class="fw-bold">
			Welcome,
			<%= (user != null ? user.getName() : "Guest") %></h2>
		<p class="text-muted">
			Email:
			<%= (user != null ? user.getEmail() : "N/A") %></p>
		<p class="text-secondary">
			Member since:
			<%= (joinedDateFormatted.isEmpty() ? "N/A" : joinedDateFormatted) %></p>

		<div class="d-flex justify-content-center gap-3 mt-4">
			<a href="#" class="btn btn-primary">View Profile</a> 
			<a href="#" class="btn btn-secondary">Settings</a> 	
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
