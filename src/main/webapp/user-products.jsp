<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product"%>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<String> brands = (List<String>) request.getAttribute("brands");
    List<String> categories = (List<String>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explore Phones | Cashify</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
body {
	background: #f8f9fa;
}

.sidebar {
	border-right: 1px solid #ddd;
	min-height: 100vh;
	background: #fff;
	padding: 20px;
	position: sticky;
	top: 0;
	height: 100vh;
}

.product-card {
	background: #fff;
	border-radius: 15px;
	transition: all .3s ease;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.product-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.card-img-top {
	height: 200px;
	object-fit: contain;
	padding: 10px;
	transition: transform .3s ease;
}

.card-img-top:hover {
	transform: scale(1.05);
}

.price {
	font-weight: bold;
	color: #2e7d32;
	font-size: 1.1rem;
}

.old-price {
	text-decoration: line-through;
	color: #999;
	margin-left: 5px;
}

.discount {
	background: #ef4444;
	color: white;
	font-size: 12px;
	padding: 3px 6px;
	border-radius: 5px;
}

.rating {
	color: #fbbf24;
}
</style>
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="container-fluid mt-3">
		<div class="row">

			<!-- Sidebar Filters -->
			<aside class="col-md-3 sidebar">
				<h5 class="fw-bold mb-3">Filters</h5>
				<form method="get"
					action="${pageContext.request.contextPath}/products">
					<div class="mb-3">
						<label class="form-label">Brand</label> <select
							class="form-select" name="brand" onchange="this.form.submit()">
							<option value="all">All</option>
							<% if (brands != null) for (String b : brands) { %>
							<option value="<%= b %>"><%= b %></option>
							<% } %>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label">Category</label> <select
							class="form-select" name="category" onchange="this.form.submit()">
							<option value="all">All</option>
							<% if (categories != null) for (String c : categories) { %>
							<option value="<%= c %>"><%= c %></option>
							<% } %>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label">Sort by</label> <select
							class="form-select" name="sort" onchange="this.form.submit()">
							<option value="">Newest</option>
							<option value="price_asc">Price: Low to High</option>
							<option value="price_desc">Price: High to Low</option>
						</select>
					</div>
				</form>
			</aside>

			<!-- Product Listing -->
			<main class="col-md-9">
				<div class="row g-4">
					<% if (products != null && !products.isEmpty()) {
             for (Product p : products) { %>
					<div class="col-sm-6 col-lg-4">
						<div class="product-card p-3">
							<img
								src="<%= request.getContextPath() + "/product-image?id=" + p.getId() %>"
								class="card-img-top" alt="<%= p.getProductName() %>">
							<h6 class="mt-2 fw-semibold"><%= p.getProductName() %></h6>
							<p class="text-muted small mb-1"><%= p.getBrand() %>
								•
								<%= p.getCategory() %></p>

							<span class="price">₹<%= Math.round(p.getDiscountedPrice()) %></span>
							<% if (p.getDiscountedPrice() < p.getPrice()) { %>
							<span class="old-price">₹<%= Math.round(p.getPrice()) %></span> <span
								class="discount ms-2"><%= Math.round((1 - p.getDiscountedPrice()/p.getPrice()) * 100) %>%
								OFF</span>
							<% } %>


							<div class="rating mb-3">
								⭐
								<%= String.format("%.1f", p.getRating()) %>
							</div>

							<div class="d-flex gap-2">
								<form method="post"
									action="${pageContext.request.contextPath}/add-to-cart">
									<input type="hidden" name="productId" value="<%= p.getId() %>">
									<button class="btn btn-success btn-sm w-100">
										<i class="fa fa-cart-plus"></i> Add
									</button>
								</form>
								<form method="post"
									action="${pageContext.request.contextPath}/wishlist">
									<input type="hidden" name="productId" value="<%= p.getId() %>">
									<button class="btn btn-outline-danger btn-sm w-100">
										<i class="fa fa-heart"></i>
									</button>
								</form>
							</div>
						</div>
					</div>
					<% } } else { %>
					<p class="text-center text-muted mt-5">No products found.</p>
					<% } %>
				</div>
			</main>
		</div>
	</div>

</body>
</html>
