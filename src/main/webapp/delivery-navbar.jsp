<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.DeliveryPerson"%>

<%
    DeliveryPerson delivery = (DeliveryPerson) session.getAttribute("deliveryPerson"); 
    if (delivery == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Delivery Dashboard | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
/* ===== Navbar ===== */
.navbar {
    background: linear-gradient(135deg, #1d2671, #c33764);
}
.navbar-brand, .nav-link { color: #fff !important; font-weight: 600; }
.navbar-brand { font-size: 1.5rem; }


</style>
</head>
<body>

<!-- ===== Navbar ===== -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="delivery-home.jsp">Cashify Delivery</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">

            <i class="bi bi-person-circle"></i> <%= delivery.getName() %>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
            <li><span class="dropdown-item">Email: <%= delivery.getEmail() %></span></li>
            <li><span class="dropdown-item">Phone: <%= delivery.getPhone() %></span></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    var dropdowns = document.querySelectorAll('.dropdown-toggle');
    dropdowns.forEach(dd => new bootstrap.Dropdown(dd));
  });
</script>
</body>
</html>
