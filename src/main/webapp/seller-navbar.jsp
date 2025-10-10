<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller"%>
<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Seller Navbar | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
/* Navbar */
.navbar {
    background: linear-gradient(90deg, #ff6a00, #ee0979); /* coral to pink gradient */
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
    background-color: #e05570; /* darker pink */
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
    background-color: #ff6a00; /* coral hover */
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

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Cashify Seller</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button">
            <i class="bi bi-person-circle"></i> <%= seller.getName() %>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><span class="dropdown-item">Email: <%= seller.getEmail() %></span></li>
            <li><span class="dropdown-item">Phone: <%= seller.getPhone() %></span></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="sellerLogout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>