<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Navbar | Cashify</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
/* Navbar */
.navbar {
      background: linear-gradient(90deg, #30d5fb, #3475a8); /* Cashify green gradient */
}
.navbar-brand, .nav-link {
    color: #fff !important;
    font-weight: 600;
}
.navbar-brand {
    font-size: 1.5rem;
}

/* Dropdown menu */
.nav-item.dropdown {
    position: relative;
}
.nav-item.dropdown .dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    right: 0;
    min-width: 220px;
    background-color: #3475a8; /* darker green */
    border-radius: 8px;
    overflow: hidden;
    transform: translateY(0);
    opacity: 0;
    transition: all 0.3s ease;
    z-index: 1000;
}
.nav-item.dropdown:hover .dropdown-menu {
    display: block;
    transform: translateY(5px);
    opacity: 1;
}

/* Dropdown items */
.dropdown-item {
    color: #fff !important;
    padding: 10px 15px;
    transition: background 0.3s;
}
.dropdown-item:hover {
    background-color: #30d5fb; /* bright green hover */
}

/* Divider */
.dropdown-divider {
    border-top: 1px solid rgba(255, 255, 255, 0.3);
}

/* No page shift on hover */
.dropdown-menu {
    will-change: transform, opacity;
}

/* Responsive adjustments */
@media (max-width: 992px) {
    .nav-item.dropdown .dropdown-menu {
        position: static;
        transform: none;
        opacity: 1;
        display: block;
        width: 100%;
        margin-top: 10px;
        border-radius: 0;
    }
}
</style>
</head>
<body>

<!-- Admin Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <!-- Brand -->
    <a class="navbar-brand" href="admin-home.jsp">
      <i class="bi bi-shield-lock-fill"></i> Cashify Admin
    </a>

    <!-- Toggler for mobile -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar links -->
    <div class="collapse navbar-collapse" id="adminNavbar">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="admin-home.jsp"><i class="bi bi-house-door"></i> Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="admin-reports.jsp"><i class="bi bi-bar-chart"></i> Reports</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="admin-manage-users.jsp"><i class="bi bi-people"></i> Users</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="admin-manage-sellers.jsp"><i class="bi bi-shop"></i> Sellers</a>
        </li>

        <!-- Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button">
            <i class="bi bi-person-circle"></i> <%= admin.getName() != null ? admin.getName() : "Admin" %>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><span class="dropdown-item">Email: <%= admin.getEmail() %></span></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="admin-profile.jsp"><i class="bi bi-person"></i> Profile</a></li>
            <li><a class="dropdown-item" href="admin-change-password.jsp"><i class="bi bi-lock"></i> Change Password</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
