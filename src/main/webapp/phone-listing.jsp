<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, java.util.Arrays"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
List<String> brands = (List<String>) request.getAttribute("brands");
List<String> categories = (List<String>) request.getAttribute("categories");
List<Integer> ramOptions = (List<Integer>) request.getAttribute("ramOptions");
List<String> colorOptions = (List<String>) request.getAttribute("colorOptions");

String selectedBrand = request.getParameter("brand") != null ? request.getParameter("brand") : "all";
String selectedCategory = request.getParameter("category") != null ? request.getParameter("category") : "all";
String selectedSort = request.getParameter("sort") != null ? request.getParameter("sort") : "";

boolean hasProducts = (products != null && !products.isEmpty());
%>

<!DOCTYPE html>
<html lang="en">
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
	background-color: #f5f7fa;
	font-family: 'Segoe UI', sans-serif;
}

/* Sidebar */
.sidebar {
	background: #fff;
	border-right: 1px solid #e0e0e0;
	padding: 20px;
	height: 100vh;
	overflow-y: auto;
	position: sticky;
	top: 0;
}

/* Product card */
.product-card {
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
	transition: all 0.25s ease;
	overflow: hidden;
	padding: 12px;
	min-height: 360px; /* ensures uniform card heights */
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

/* image: fixed height and centered */
.card-img-top {
	height: 200px; /* fixed height */
	width: 100%;
	object-fit: contain; /* maintain aspect ratio */
	display: block;
	margin: 0 auto 8px auto;
	transition: transform 0.25s ease;
}

.card-img-top:hover {
	transform: scale(1.05);
}

.price {
	color: #2e7d32;
	font-weight: 700;
	font-size: 1rem;
}

.old-price {
	text-decoration: line-through;
	color: #999;
	font-size: 0.85rem;
	margin-left: 6px;
}

.discount {
	font-size: 0.75rem;
	background: #dc3545;
	color: #fff;
	border-radius: 6px;
	padding: 3px 6px;
	margin-left: 6px;
}

.rating {
	color: #f4c430;
	font-size: 0.85rem;
}

.wishlist-btn {
	position: absolute;
	top: 10px;
	right: 10px;
	background: #fff;
	border: none;
	border-radius: 50%;
	padding: 6px 8px;
	transition: transform 0.2s ease, background 0.3s;
}

.wishlist-btn:hover {
	transform: scale(1.15);
	background: #ffe6e6;
}

/* grid tweaks */
.row.g-3 {
	align-items: stretch;
}

/* responsive */
@media ( max-width : 768px) {
	.sidebar {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 260px;
		z-index: 1050;
		height: 100%;
		box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
		overflow-y: auto;
		transition: all 0.3s ease;
	}
	.sidebar.active {
		display: block;
	}
}

/* disabled select style hint */
select[disabled] {
	background-color: #f8f9fa;
	cursor: not-allowed;
}
</style>
</head>
<body>
	<%
	if (request.getAttribute("products") == null) {
		response.sendRedirect("products");
		return;
	}
	%>

	<jsp:include page="header.jsp"></jsp:include>

	<div class="container-fluid mt-3">
		<div class="row">
			<!-- Sidebar Filters -->
			<aside class="col-md-3 sidebar" id="filterSidebar">
				<h5>Filters</h5>
				<form method="get" action="products" id="filterForm">

					<!-- Preserve Sort when filters change -->
					<input type="hidden" name="sort" value="<%=selectedSort%>">

					<!-- Brand -->
					<div class="mb-3">
						<label class="form-label fw-semibold">Brand</label> <select
							class="form-select form-select-sm" name="brand"
							onchange="this.form.submit()">
							<option value="all"
								<%=selectedBrand.equals("all") ? "selected" : ""%>>All</option>
							<%
							if (brands != null)
								for (String b : brands) {
							%>
							<option value="<%=b%>"
								<%=b.equals(selectedBrand) ? "selected" : ""%>><%=b%></option>
							<%
							}
							%>
						</select>
					</div>

					<!-- Category -->
					<div class="mb-3">
						<label class="form-label fw-semibold">Category</label> <select
							class="form-select form-select-sm" name="category"
							onchange="this.form.submit()">
							<option value="all"
								<%=selectedCategory.equals("all") ? "selected" : ""%>>All</option>
							<%
							if (categories != null)
								for (String c : categories) {
							%>
							<option value="<%=c%>"
								<%=c.equals(selectedCategory) ? "selected" : ""%>><%=c%></option>
							<%
							}
							%>
						</select>
					</div>

					<!-- RAM (multiple) -->
					<div class="mb-3">
						<label class="form-label fw-semibold">RAM</label>
						<%
						if (ramOptions != null)
							for (Integer r : ramOptions) {
								boolean checked = request.getParameterValues("ram") != null
								&& Arrays.asList(request.getParameterValues("ram")).contains(r.toString());
						%>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="ram"
								value="<%=r%>" <%=checked ? "checked" : ""%>
								onchange="this.form.submit()"> <label
								class="form-check-label"><%=r%> GB</label>
						</div>
						<%
						}
						%>
					</div>

					<!-- Color (multiple) -->
					<div class="mb-3">
						<label class="form-label fw-semibold">Color</label>
						<%
						if (colorOptions != null)
							for (String co : colorOptions) {
								boolean checked = request.getParameterValues("color") != null
								&& Arrays.asList(request.getParameterValues("color")).contains(co);
						%>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="color"
								value="<%=co%>" <%=checked ? "checked" : ""%>
								onchange="this.form.submit()"> <label
								class="form-check-label"><%=co%></label>
						</div>
						<%
						}
						%>
					</div>

				</form>
			</aside>

			<!-- Main Product Section -->
			<main class="col-md-9">
				<button class="btn btn-outline-primary mb-3" id="filterToggle">
					<i class="fa fa-filter me-1"></i>Filters
				</button>

				<!-- Sorting -->
				<div class="d-flex justify-content-end align-items-center mb-3">
					<form method="get" action="products"
						class="d-flex align-items-center gap-2" id="sortForm"
						data-has-products="<%=hasProducts%>">
						<!-- Preserve current filters while sorting -->
						<input type="hidden" name="brand" value="<%=selectedBrand%>">
						<input type="hidden" name="category" value="<%=selectedCategory%>">

						<%
						if (request.getParameterValues("ram") != null) {
							for (String r : request.getParameterValues("ram")) {
						%>
						<input type="hidden" name="ram" value="<%=r%>">
						<%
						}
						}
						%>

						<%
						if (request.getParameterValues("color") != null) {
							for (String c : request.getParameterValues("color")) {
						%>
						<input type="hidden" name="color" value="<%=c%>">
						<%
						}
						}
						%>

						<label class="me-2 small fw-semibold">Sort by:</label>

						<!-- Disable sort when there are no products -->
						<select class="form-select form-select-sm" name="sort"
							onchange="this.form.submit()"
							<%=!hasProducts ? "disabled title='No products to sort — change filters first'" : ""%>>
							<option value="">Newest</option>
							<option value="price_asc"
								<%="price_asc".equals(selectedSort) ? "selected" : ""%>>Price:
								Low to High</option>
							<option value="price_desc"
								<%="price_desc".equals(selectedSort) ? "selected" : ""%>>Price:
								High to Low</option>
						</select>
					</form>
				</div>

				<!-- Product Listing -->
				<div class="row g-3" id="productGrid"
					data-has-products="<%=hasProducts%>">
					<%
					if (hasProducts) {
						for (Product p : products) {
					%>
					<div class="col-sm-6 col-lg-4 d-flex">
						<div class="product-card position-relative w-100">
							<!-- Wishlist -->
							<form method="post"
								action="${pageContext.request.contextPath}/wishlist"
								class="wishlist-form">
								<input type="hidden" name="productId" value="<%=p.getId()%>">
								<button type="button" class="wishlist-btn"
									data-product-id="<%=p.getId()%>">
									<i class="fa-regular fa-heart"></i>
								</button>
							</form>


							<!-- Image -->
							<img
								src="<%=request.getContextPath() + "/product-image?id=" + p.getId()%>"
								class="card-img-top mb-2" alt="<%=p.getProductName()%>">

							<!-- Product Info -->
							<div>
								<h6 class="fw-bold text-dark mb-0"><%=p.getProductName()%></h6>
								<p class="text-muted small mb-1"><%=p.getBrand()%>
									•
									<%=p.getCategory()%></p>
								<div class="mb-1">
									<span class="badge bg-info text-dark"><%=p.getRam()%>GB</span>
									<span class="badge bg-secondary"><%=p.getColor()%></span>
								</div>

								<div class="mb-1">
									<span class="price">₹<%=Math.round(p.getDiscountedPrice())%></span>
									<%
									if (p.getDiscountedPrice() < p.getPrice()) {
									%>
									<span class="old-price">₹<%=Math.round(p.getPrice())%></span> <span
										class="discount"> <%=Math.round((1 - p.getDiscountedPrice() / p.getPrice()) * 100)%>%
										OFF
									</span>
									<%
									}
									%>
								</div>

								<div class="rating mb-2">
									⭐
									<%=String.format("%.1f", p.getRating())%></div>
							</div>

							<!-- Buttons -->
							<div class="d-flex gap-2 mt-2">
								<form action="addToCart" method="post" class="w-50">
									<input type="hidden" name="action" value="add"> <input
										type="hidden" name="productId" value="<%=p.getId()%>">
									<button class="btn btn-success btn-sm w-100">
										<i class="fa fa-cart-plus me-1"></i>Add
									</button>
								</form>

								<form method="post"
									action="${pageContext.request.contextPath}/buy-now"
									class="w-50">
									<input type="hidden" name="productId" value="<%=p.getId()%>">
									<button class="btn btn-primary btn-sm w-100">
										<i class="fa fa-bolt me-1"></i>Buy
									</button>
								</form>
							</div>
						</div>
					</div>
					<%
					}
					} else {
					%>
					<div class="col-12 text-center text-muted mt-5">
						<i class="fa fa-box-open fa-3x mb-2"></i>
						<p>No products found. Try removing some filters or change
							sorting.</p>
					</div>
					<%
					}
					%>
				</div>
			</main>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
 // mobile filter toggle
 document.getElementById("filterToggle").addEventListener("click", () => {
     document.getElementById("filterSidebar").classList.toggle("active");
 });

 // Protect sorting: if no products, prevent sort form submission (double-safety)
 (function(){
     const sortForm = document.getElementById('sortForm');
     if (!sortForm) return;
     const hasProducts = sortForm.getAttribute('data-has-products') === 'true';
     sortForm.addEventListener('submit', function(e){
         if (!hasProducts) {
             e.preventDefault();
             // notify user (gentle)
             alert('No products to sort. Please change filters first.');
         }
     });

     // Also disable programmatic selects on disabled attribute
     const sortSelect = sortForm.querySelector('select[name="sort"]');
     if (sortSelect && sortSelect.disabled) {
         sortSelect.addEventListener('click', function(e){ e.preventDefault(); });
     }
 })();
 
 document.querySelectorAll(".wishlist-btn").forEach(btn => {
	    btn.addEventListener("click", async function () {
	        let icon = this.querySelector("i");
	        let productId = this.getAttribute("data-product-id");

	        // Immediate UI toggle
	        icon.classList.toggle("fa-solid");
	        icon.classList.toggle("fa-regular");
	        icon.classList.toggle("text-danger");

	        try {
	            let res = await fetch(
	                "<%=request.getContextPath()%>/wishlist",
	                {
	                    method: "POST",
	                    credentials: "include",      // ✅ SEND SESSION COOKIE
	                    headers: {
	                        "Content-Type": "application/x-www-form-urlencoded"
	                    },
	                    body: "productId=" + productId
	                }
	            );

	            if (res.status === 401) {
	                alert("Please login to add to wishlist.");
	                window.location.href = "<%=request.getContextPath()%>/login.jsp";
	            }

	        } catch (err) {
	            console.error("Error:", err);
	        }
	    });
	});

</script>
</body>
</html>
