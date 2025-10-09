<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.SalesDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.SalesReport" %>

<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SalesDao dao = new SalesDao();
    List<SalesReport> salesList = dao.getSalesBySellerId(seller.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sales Report | Seller Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f7f7fa;
}
.sidebar {
    min-height: 100vh;
    background-color: #fff;
    border-right: 1px solid #ddd;
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
    color: #fff;
    padding-left: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}
.sidebar a.active {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    color: #fff;
}
.text-gradient {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
</style>
</head>
<body>

<jsp:include page="seller-navbar.jsp"></jsp:include>

<div class="container-fluid">
  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3 sidebar">
      <a href="seller-home.jsp"><i class="bi bi-house-door"></i> Dashboard</a>
      <a href="seller-added-items.jsp"><i class="bi bi-plus-circle"></i> Sell a Phone</a>
      <a href="seller-listing.jsp"><i class="bi bi-phone"></i> My Listings</a>
      <a href="seller-sales-report.jsp" class="active"><i class="bi bi-bar-chart"></i> Sales Report</a>
      <a href="seller-settings.jsp"><i class="bi bi-gear"></i> Settings</a>
    </div>

    <!-- Main Content -->
    <div class="col-md-9 py-4">
      <h3 class="fw-bold mb-4 text-center text-gradient">📊 My Sales Report</h3>

      <% if (salesList == null || salesList.isEmpty()) { %>
        <div class="text-center text-muted mt-5">
          <i class="bi bi-bar-chart-line display-3"></i>
          <h5 class="mt-3">No sales yet</h5>
          <p>Start selling your products to generate sales report!</p>
        </div>
      <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle">
            <thead class="table-dark">
              <tr>
                <th>#</th>
                <th>Product</th>
                <th>Brand</th>
                <th>Total Quantity Sold</th>
                <th>Total Revenue (₹)</th>
              </tr>
            </thead>
            <tbody>
              <% int i = 1;
                 for (SalesReport s : salesList) { %>
                <tr>
                  <td><%= i++ %></td>
                  <td><%= s.getProductName() %></td>
                  <td><%= s.getBrand() %></td>
                  <td><%= s.getTotalQuantity() %></td>
                  <td>₹<%= String.format("%.2f", s.getTotalRevenue()) %></td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      <% } %>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
