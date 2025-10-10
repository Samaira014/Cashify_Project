<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller"%>
<%@ page import="com.cashify.servlet_cashify_project.dao.ProductDao"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product"%>

<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ProductDao dao = new ProductDao();
    List<Product> productList = dao.getProductsBySellerId(seller.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Listings | Seller Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f7f7fa;
}

/* Sidebar */
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
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.sidebar a.active {
	background: linear-gradient(90deg, #ff6a00, #ee0979);
	color: #fff;
}

/* 🔸 Reuse same animation for table */
@keyframes fadeInUp {
	from { opacity: 0; transform: translateY(30px); }
	to { opacity: 1; transform: translateY(0); }
}

/* Product cards */
.product-card {
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
	transition: all 0.3s;
	animation: fadeInUp 0.6s ease forwards;
}

.product-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

/* 🔸 New: animation for right-side listing table */
.table-animate {
	animation: fadeInUp 0.7s ease forwards;
}

/* Image styling */
.product-img {
	height: 180px;
	object-fit: contain;
	border-bottom: 1px solid #eee;
	padding: 15px;
}

.product-body {
	padding: 15px;
}

.status-badge {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 500;
}

.bg-pending {
	background-color: #fff3cd;
	color: #856404;
	border: 1px solid #ffeeba;
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
	font-weight: 600;
}

.bg-verified {
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
	font-weight: 600;
}

.bg-rejected {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
	font-weight: 600;
}

/* Responsive Grid */
@media (max-width: 768px) {
	.sidebar {
		display: none;
	}
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
				<a href="seller-listing.jsp" class="active"><i class="bi bi-phone"></i> My Listings</a>
				<a href="seller-sales-report.jsp"><i class="bi bi-bar-chart"></i> Sales Report</a>
				<a href="seller-settings.jsp"><i class="bi bi-gear"></i> Settings</a>
			</div>

			<!-- Main Content -->
			<div class="col-md-9 py-4 table-animate">
				<h3 class="fw-bold mb-4 text-center text-gradient">📱 My Product Listings</h3>

				<% if (productList == null || productList.isEmpty()) { %>
				<div class="text-center text-muted mt-5">
					<i class="bi bi-box-seam display-3"></i>
					<h5 class="mt-3">No listings yet</h5>
					<p>Add your first phone or gadget to start selling!</p>
					<a href="seller-added-items.jsp" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Add Product</a>
				</div>
				<% } else { %>
				<div class="row g-4">
					<% int i = 0;
					   for (Product p : productList) { 
					       String delay = String.format("%.1fs", i * 0.1);
					%>
					<div class="col-sm-6 col-md-4 col-lg-3" style="animation-delay: <%= delay %>;">
						<div class="product-card">
							<img
								src="<%= (p.getImage() != null) ? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(p.getImage()) : "https://via.placeholder.com/300x200?text=No+Image" %>"
								alt="<%= p.getProductName()%>" class="product-img w-100" />
							<div class="product-body">
								<h5 class="fw-semibold"><%= p.getBrand() %> <%= p.getProductName()%></h5>
								<p class="small text-muted mb-1"><%= p.getCategory() %></p>
								<p class="mb-1">💰 <strong>₹<%= p.getPrice() %></strong></p>
								
								<!-- Discounted Price (display only, added by admin) -->
								<p class="mb-1 text-success">
									Discounted: 
									<%= (p.getDiscountedPrice() != null && p.getDiscountedPrice() > 0) ? "₹" + p.getDiscountedPrice() : "Pending" %>
								</p>

								<!-- Status Badge -->
								<p>
									<span class="status-badge
										<%= p.isVerified() ? "bg-verified" :
											(p.getRejection_msg() != null ? "bg-rejected" : "bg-pending") %>">
										<%= p.isVerified() ? "Verified" :
											(p.getRejection_msg() != null ? "Rejected: " + p.getRejection_msg() : "Pending Approval") %>
									</span>
								</p>

								<!-- Remove Button -->
								<form method="post" action="delete-product"
									onsubmit="return confirm('Are you sure you want to delete this product?');">
									<input type="hidden" name="productId" value="<%= p.getId() %>">
									<button type="submit" class="btn btn-danger w-100 mt-2">
										<i class="bi bi-trash"></i> Remove
									</button>
								</form>
							</div>
						</div>
					</div>
					<% i++; } %>
				</div>
				<% } %>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
