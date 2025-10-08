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
<html>
<head>
<meta charset="UTF-8">
<title>Seller Dashboard | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
/* Global Styles */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f0f0f5;
    overflow-x: hidden;
}

/* Sidebar */
.sidebar {
    min-height: 100vh;
    background-color: #fff;
    border-right: 1px solid #dee2e6;
    padding-top: 20px;
}
.sidebar a {
    color: #e22d78;
    display: block;
    padding: 12px 20px;
    margin: 5px 10px;
    border-radius: 8px;
    text-decoration: none;
    transition: all 0.3s;
}
.sidebar a:hover {
    background: linear-gradient(90deg, #ff6a00, #ee0979); 
    color: #fff !important;
    padding-left: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}
.sidebar a.active {
    background: linear-gradient(90deg, #ff6a00, #ee0979); 
    color: #fff !important;
}

/* Profile Card */
.profile-card {
    border-radius: 12px;
    padding: 25px;
    background: #ffffff;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeInUp 0.6s forwards;
}
.profile-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.15);
}

/* Dashboard Cards */
.card {
    border-radius: 12px;
    transition: transform 0.3s, box-shadow 0.3s;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeInUp 0.6s forwards;
    background-color: #fff0f7;
    border: 1px solid #e0d4f7;
}
.card:hover {
    transform: translateY(-10px) scale(1.05);
    box-shadow: 0 12px 20px rgba(0,0,0,0.15);
}
.card:nth-child(1) { animation-delay: 0.1s; }
.card:nth-child(2) { animation-delay: 0.2s; }
.card:nth-child(3) { animation-delay: 0.3s; }

/* Buttons */
.btn-primary {
    background: linear-gradient(90deg, #ff6a00, #ee0979); 
    border: none;
    color: #fff;
    transition: transform 0.2s, box-shadow 0.2s;
}
.btn-primary:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Hover gradient animation for "View My Listings" */
.btn-hover-gradient {
    border-color: #e22d78;
    color: #e22d78;
    background-color: transparent;
    position: relative;
    overflow: hidden;
    transition: color 0.3s, transform 0.2s, box-shadow 0.2s;
}
.btn-hover-gradient::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    transition: all 0.4s;
    z-index: 0;
}
.btn-hover-gradient:hover::before {
    left: 0;
}
.btn-hover-gradient span {
    position: relative;
    z-index: 1;
}
.btn-hover-gradient:hover {
    color: #fff;
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Animations */
@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>
<body>

<jsp:include page="seller-navbar.jsp"></jsp:include>

<div class="container-fluid mt-4">
  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3 sidebar">
        <a href="seller-home.jsp" class="active"><i class="bi bi-house-door-fill"></i> Dashboard</a>
        <a href="sell-electronic-items.jsp"><i class="bi bi-plus-circle"></i> Sell a Phone</a>
        <a href="my-listings.jsp"><i class="bi bi-phone"></i> My Listings</a>
        <a href="#"><i class="bi bi-graph-up"></i> Sales Reports</a>
        <a href="#"><i class="bi bi-gear-fill"></i> Settings</a>
    </div>

    <!-- Main Content -->
    <div class="col-md-9">
        <!-- Profile Card -->
        <div class="profile-card text-center mb-4">
            <h3>Welcome, <%= seller.getName() %> 👋</h3>
            <p class="text-muted">You are logged in as a verified seller on Cashify.</p>
            <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="sell-electronic-items.jsp" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Sell a Phone</a>
                <a href="my-listings.jsp" class="btn btn-outline-primary btn-hover-gradient"><span><i class="bi bi-list"></i> View My Listings</span></a>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card text-center p-3">
                    <h5>Total Phones Listed</h5>
                    <h2>12</h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card text-center p-3">
                    <h5>Verified Listings</h5>
                    <h2>10</h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card text-center p-3">
                    <h5>Pending Approvals</h5>
                    <h2>2</h2>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
