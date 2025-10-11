<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product"%>
<%
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("products");
    @SuppressWarnings("unchecked")
    List<String> brands = (List<String>) request.getAttribute("brands");
    @SuppressWarnings("unchecked")
    List<String> categories = (List<String>) request.getAttribute("categories");

    String selectedBrand = request.getParameter("brand") == null ? "all" : request.getParameter("brand");
    String selectedCategory = request.getParameter("category") == null ? "all" : request.getParameter("category");
    String selectedSort = request.getParameter("sort") == null ? "" : request.getParameter("sort");
    String q = request.getParameter("q") == null ? "" : request.getParameter("q");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Buy Phones Online - Cashify Store</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f9fafb;
	font-family: 'Poppins', sans-serif;
	overflow-x: hidden;
}

/* Sidebar */
.sidebar {
	background: #fff;
	border-radius: 15px;
	padding: 25px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
	position: sticky;
	top: 100px;
}

.filter-title {
	font-weight: 600;
	color: #111827;
}

.form-select, .form-control {
	border-radius: 10px;
	border: 1px solid #e5e7eb;
	transition: all 0.3s;
}

.form-select:hover, .form-control:hover {
	border-color: #16a34a;
	box-shadow: 0 4px 10px rgba(22, 163, 52, 0.1);
}

/* Product Grid */
.product-card {
	background: #fff;
	border-radius: 15px;
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.product-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
}

.card-img {
	height: 220px;
	object-fit: contain;
	transition: transform 0.3s ease;
	background: #f9fafb;
}

.product-card:hover .card-img {
	transform: scale(1.05);
}

/* Price & Rating */
.price {
	font-weight: 700;
	color: #16a34a;
	font-size: 1.1rem;
}

.old-price {
	text-decoration: line-through;
	color: #9ca3af;
	margin-left: 8px;
}

.badge-discount {
	background: #ef4444;
	color: white;
	font-size: 13px;
	padding: 3px 6px;
	border-radius: 6px;
	margin-left: 6px;
}

.rating i {
	color: #fbbf24;
}

/* Buttons */
.btn-success {
	background: linear-gradient(90deg, #16a34a, #22c55e);
	border: none;
	font-weight: 500;
	transition: all 0.3s;
}

.btn-success:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(22, 163, 52, 0.3);
}

.btn-outline-secondary:hover {
	background-color: #f3f4f6;
}

/* Fade-in animation */
.fade-in {
	animation: fadeIn 0.5s ease forwards;
	opacity: 0;
}

@
keyframes fadeIn {to { opacity:1;
	
}

}

/* Responsive tweaks */
@media ( max-width : 768px) {
	.sidebar {
		margin-bottom: 20px;
	}
}

@media ( max-width : 576px) {
	.col-12-col-sm-6-col-lg-4 {
		width: 100%;
	}
	.card-img {
		height: 180px;
	}
	.product-card .p-3 {
		padding: 12px;
	}
	.d-flex.gap-2 {
		flex-direction: column;
	}
	.price {
		font-size: 1rem;
	}
	.old-price {
		font-size: 0.9rem;
	}
	.badge-discount {
		font-size: 11px;
		padding: 2px 5px;
	}
	.rating {
		font-size: 0.9rem;
	}
}
</style>
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row g-4">

			<!-- Sidebar -->
			<aside class="col-md-3 sidebar fade-in">
				<form id="filterForm" method="GET" action="/products">
					<div class="mb-3">
						<label class="form-label filter-title">Search</label> <input
							type="text" name="q" value="<%= q %>"
							class="form-control shadow-sm"
							placeholder="Search phone or brand">
					</div>

					<div class="mb-3">
						<label class="form-label filter-title">Brand</label> <select
							name="brand" class="form-select shadow-sm"
							onchange="document.getElementById('filterForm').submit();">
							<option value="all">All</option>
							<% if (brands != null) for (String b : brands) { %>
							<option value="<%=b%>"
								<%= b.equals(selectedBrand) ? "selected" : "" %>><%=b%></option>
							<% } %>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label filter-title">Category</label> <select
							name="category" class="form-select shadow-sm"
							onchange="document.getElementById('filterForm').submit();">
							<option value="all">All</option>
							<% if (categories != null) for (String c : categories) { %>
							<option value="<%=c%>"
								<%= c.equals(selectedCategory) ? "selected" : "" %>><%=c%></option>
							<% } %>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label filter-title">Sort by</label> <select
							name="sort" class="form-select shadow-sm"
							onchange="document.getElementById('filterForm').submit();">
							<option value="">Newest</option>
							<option value="price_asc"
								<%= "price_asc".equals(selectedSort) ? "selected" : "" %>>Price:
								Low to High</option>
							<option value="price_desc"
								<%= "price_desc".equals(selectedSort) ? "selected" : "" %>>Price:
								High to Low</option>
						</select>
					</div>
				</form>
			</aside>

			<!-- Products -->
			<main class="col-md-9 fade-in">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<h3 class="fw-bold text-secondary">Smartphones</h3>
					<div>
						<small class="text-muted"><%= (products != null) ? products.size() : 0 %>
							items found</small>
					</div>
				</div>

				<div class="row g-4">
					<% if (products != null && !products.isEmpty()) {
                    for (Product p : products) { %>
					<div class="col-12 col-sm-6 col-lg-4">
						<div class="product-card shadow-sm fade-in">
							<div class="position-relative">
								<img
									src="<%= request.getContextPath() + "/product-image?id=" + p.getId() %>"
									class="card-img">
								<form method="post"
									action="${pageContext.request.contextPath}/wishlist"
									class="position-absolute top-0 end-0 m-2">
									<input type="hidden" name="productId" value="<%= p.getId() %>">
									<button class="btn btn-light rounded-circle shadow-sm"
										title="Add to wishlist">
										<i class="fa fa-heart"></i>
									</button>
								</form>
							</div>
							<div class="p-3">
								<h6 class="fw-semibold mb-1"><%= p.getProductName() %></h6>
								<small class="text-muted d-block mb-2"><%= p.getBrand() %>
									• <%= p.getCategory() %></small>
								<div class="d-flex align-items-center mb-2 flex-wrap">
									<span class="price">₹<%= Math.round(p.getDiscountedPrice() != null ? p.getDiscountedPrice() : p.getPrice()) %></span>
									<% if (p.getDiscountedPrice() != null) { %>
									<span class="old-price">₹<%= Math.round(p.getPrice()) %></span>
									<span class="badge-discount"><%= Math.round((1 - p.getDiscountedPrice()/p.getPrice())*100) %>%
										OFF</span>
									<% } %>
								</div>
								<div class="rating mb-3">
									<% for(int i=1; i<=5; i++) { %>
									<i
										class="fa fa-star <%= i <= Math.round(p.getRating()) ? "text-warning" : "text-secondary" %>"></i>
									<% } %>
									<small class="text-muted">(<%= String.format("%.1f", p.getRating()) %>)
									</small>
								</div>
								<div class="d-flex gap-2 flex-wrap">
									<form method="post"
										action="${pageContext.request.contextPath}/add-to-cart"
										class="w-100">
										<input type="hidden" name="productId" value="<%= p.getId() %>">
										<button class="btn btn-success w-100">
											<i class="fa fa-cart-plus me-1"></i>Add to Cart
										</button>
									</form>
									<a href="product-details.jsp?id=<%= p.getId() %>"
										class="btn btn-outline-secondary w-100"> <i
										class="fa fa-eye me-1"></i>View
									</a>
								</div>
							</div>
						</div>
					</div>
					<% } } else { %>
					<div class="col-12 text-center text-muted py-5">
						<i class="fa fa-box-open fa-3x mb-3"></i>
						<h5>No products found</h5>
					</div>
					<% } %>
				</div>
			</main>
		</div>
	</div>
</body>
</html>
