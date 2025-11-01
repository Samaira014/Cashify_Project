<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.ProductDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product" %>

<%
    ProductDao dao = new ProductDao();
    List<Product> products = dao.getAllProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin | Manage Seller Products</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
  font-family: 'Poppins', sans-serif;
  background-color: #f8f9fb;
}

/* Navbar */
.navbar {
  background: linear-gradient(90deg, #ff6a00, #ee0979);
}
.navbar-brand {
  color: #fff !important;
  font-weight: 600;
  font-size: 1.3rem;
}
.navbar .nav-link {
  color: #fff !important;
  margin-left: 15px;
  transition: all 0.3s;
}
.navbar .nav-link:hover {
  text-decoration: underline;
}

/* Page Heading */
.page-title {
  text-align: center;
  font-weight: 600;
  color: #e22d78;
  margin: 30px 0;
  animation: fadeInDown 0.6s ease;
}

/* Table Card */
.table-container {
  background: #fff;
  border-radius: 12px;
  padding: 25px;
  box-shadow: 0 6px 20px rgba(0,0,0,0.1);
  animation: fadeInUp 0.7s ease;
}

.table img {
  height: 80px;
  width: 80px;
  object-fit: contain;
  border-radius: 10px;
}

/* Buttons */
.btn-verify {
  background: linear-gradient(90deg, #00c851, #007e33);
  color: white;
  border: none;
  transition: all 0.2s ease;
}
.btn-verify:hover {
  background: linear-gradient(90deg, #007e33, #00c851);
  transform: scale(1.1);
}

.btn-unverify {
  background: linear-gradient(90deg, #ff4444, #cc0000);
  color: white;
  border: none;
  transition: all 0.2s ease;
}
.btn-unverify:hover {
  background: linear-gradient(90deg, #cc0000, #ff4444);
  transform: scale(1.1);
}

/* Table Row Hover Animation */
.table tbody tr {
  transition: all 0.3s ease;
  cursor: pointer;
}
.table tbody tr:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
  background-color: #fdf2f2;
}

/* Animations */
@keyframes fadeInUp {
  0% { opacity: 0; transform: translateY(20px); }
  100% { opacity: 1; transform: translateY(0); }
}
@keyframes fadeInDown {
  0% { opacity: 0; transform: translateY(-20px); }
  100% { opacity: 1; transform: translateY(0); }
}

/* Responsive */
@media (max-width: 768px) {
  .table-container {
    padding: 10px;
  }
  .table thead {
    display: none;
  }
  .table, .table tbody, .table tr, .table td {
    display: block;
    width: 100%;
  }
  .table tr {
    margin-bottom: 15px;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
  }
  .table td {
    text-align: right;
    padding-left: 50%;
    position: relative;
  }
  .table td::before {
    content: attr(data-label);
    position: absolute;
    left: 15px;
    width: 45%;
    font-weight: 600;
    text-align: left;
  }
}
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Admin Dashboard</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item"><a href="admin-home.jsp" class="nav-link">Home</a></li>
        <li class="nav-item"><a href="admin-seller-products.jsp" class="nav-link active">Seller Listings</a></li>
        <li class="nav-item"><a href="logout.jsp" class="nav-link">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="container mt-4">
  <h2 class="page-title">📋 Seller Product Listings</h2>

  <div class="table-container table-responsive">
    <table class="table align-middle table-hover">
      <thead class="table-light">
        <tr>
          <th>Image</th>
          <th>Product Name</th>
          <th>Brand</th>
          <th>Seller ID</th>
          <th>Price</th>
          <th>Discounted Price</th>
          <th>Verified</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% if (products == null || products.isEmpty()) { %>
          <tr>
            <td colspan="8" class="text-center text-muted">No products found.</td>
          </tr>
        <% } else {
              for (Product p : products) { %>
            <tr>
              <td data-label="Image">
                <img src="<%= (p.getImage() != null) ? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(p.getImage()) : "https://via.placeholder.com/80" %>" alt="<%= p.getProductName() %>">
              </td>
              <td data-label="Product"><%= p.getProductName() %></td>
              <td data-label="Brand"><%= p.getBrand() %></td>
              <td data-label="Seller ID"><%= p.getSellerId() %></td>
              <td data-label="Price">₹<%= p.getPrice() %></td>
              <td data-label="Discounted">
                <form action="UpdateDiscountServlet" method="post" class="d-flex">
                  <input type="hidden" name="ProductName" value="<%= p.getProductName() %>">
                  <input type="number" name="discountedPrice" class="form-control form-control-sm me-2" 
                         value="<%= (p.getDiscountedPrice() != null) ? p.getDiscountedPrice() : "" %>" placeholder="₹" step="0.01">
                  <button type="submit" class="btn btn-sm btn-primary">Save</button>
                </form>
              </td>
              <td data-label="Verified">
                <% if (p.isVerified()) { %>
                  <span class="badge bg-success">Yes</span>
                <% } else { %>
                  <span class="badge bg-warning text-dark">Pending</span>
                <% } %>
              </td>
              <td data-label="Actions">
                <% if (!p.isVerified()) { %>
                  <form action="VerifyProductServlet" method="post" class="d-inline me-1">
                    <input type="hidden" name="productName" value="<%= p.getProductName() %>">
                    <button type="submit" class="btn btn-sm btn-verify"><i class="bi bi-check-circle"></i></button>
                  </form>
                <% } else { %>
                  <form action="UnverifyProductServlet" method="post" class="d-inline">
                    <input type="hidden" name="ProductName" value="<%= p.getProductName() %>">
                    <button type="submit" class="btn btn-sm btn-unverify"><i class="bi bi-x-circle"></i></button>
                  </form>
                <% } %>
              </td>
            </tr>
        <% } } %>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
