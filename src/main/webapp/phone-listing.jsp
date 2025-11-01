<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Arrays" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<String> brands = (List<String>) request.getAttribute("brands");
    List<String> categories = (List<String>) request.getAttribute("categories");
    List<Integer> ramOptions = (List<Integer>) request.getAttribute("ramOptions");
    List<String> colorOptions = (List<String>) request.getAttribute("colorOptions");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Explore Phones | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
body {
    background-color: #f5f7fa;
    font-family: 'Segoe UI', sans-serif;
}
.sidebar {
    background: #fff;
    border-right: 1px solid #e0e0e0;
    padding: 20px;
    height: 100vh;
    overflow-y: auto;
    position: sticky;
    top: 0;
}
.sidebar h5 {
    font-weight: 600;
    margin-bottom: 15px;
    color: #333;
}
.product-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    overflow: hidden;
    padding: 12px;
}
.product-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}
.card-img-top {
    height: 160px;
    object-fit: contain;
    transition: transform 0.3s ease;
}
.card-img-top:hover { transform: scale(1.08); }
.price { color: #2e7d32; font-weight: 700; font-size: 1rem; }
.old-price { text-decoration: line-through; color: #999; font-size: 0.85rem; margin-left: 5px; }
.discount {
    font-size: 0.75rem;
    background: #dc3545;
    color: #fff;
    border-radius: 6px;
    padding: 3px 6px;
    margin-left: 5px;
}
.rating { color: #f4c430; font-size: 0.8rem; }
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
    transform: scale(1.2);
    background: #ffe6e6;
}
#filterToggle {
    display: none;
}
@media (max-width: 768px) {
    .sidebar {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 240px;
        z-index: 1050;
        height: 100%;
        box-shadow: 0 0 20px rgba(0,0,0,0.2);
        overflow-y: auto;
        transition: all 0.3s ease;
    }
    .sidebar.active { display: block; }
    #filterToggle { display: block; }
}
</style>
</head>

<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid mt-3">
    <div class="row">
        <!-- Sidebar Filters -->
        <aside class="col-md-3 sidebar" id="filterSidebar">
            <h5>Filters</h5>
            <form method="get" action="products">
                <!-- Brand -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Brand</label>
                    <select class="form-select form-select-sm" name="brand" onchange="this.form.submit()">
                        <option value="all">All</option>
                        <% if (brands != null) for (String b : brands) { %>
                            <option value="<%=b%>" <%= b.equals(request.getParameter("brand")) ? "selected" : "" %>><%=b%></option>
                        <% } %>
                    </select>
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Category</label>
                    <select class="form-select form-select-sm" name="category" onchange="this.form.submit()">
                        <option value="all">All</option>
                        <% if (categories != null) for (String c : categories) { %>
                            <option value="<%=c%>" <%= c.equals(request.getParameter("category")) ? "selected" : "" %>><%=c%></option>
                        <% } %>
                    </select>
                </div>

                <!-- RAM -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">RAM</label>
                    <% if (ramOptions != null) for (Integer r : ramOptions) { %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="ram" value="<%=r%>"
                                   <%= request.getParameterValues("ram") != null && Arrays.asList(request.getParameterValues("ram")).contains(String.valueOf(r)) ? "checked" : "" %>
                                   onchange="this.form.submit()">
                            <label class="form-check-label"><%=r%> GB</label>
                        </div>
                    <% } %>
                </div>

                <!-- Color -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Color</label>
                    <% if (colorOptions != null) for (String co : colorOptions) { %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="color" value="<%=co%>"
                                   <%= request.getParameterValues("color") != null && Arrays.asList(request.getParameterValues("color")).contains(co) ? "checked" : "" %>
                                   onchange="this.form.submit()">
                            <label class="form-check-label"><%=co%></label>
                        </div>
                    <% } %>
                </div>
            </form>
        </aside>

        <!-- Main Product Section -->
        <main class="col-md-9">
            <button class="btn btn-outline-primary mb-3" id="filterToggle"><i class="fa fa-filter me-1"></i>Filters</button>

            <!-- Sorting -->
            <div class="d-flex justify-content-end align-items-center mb-2">
                <form method="get" action="products" class="d-flex align-items-center gap-2">
                    <label class="me-2 small fw-semibold">Sort by:</label>
                    <select class="form-select form-select-sm" name="sort" onchange="this.form.submit()">
                        <option value="">Newest</option>
                        <option value="price_asc" <%= "price_asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: Low to High</option>
                        <option value="price_desc" <%= "price_desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: High to Low</option>
                    </select>
                </form>
            </div>

            <!-- Product Listing -->
            <div class="row g-3">
                <% if (products != null && !products.isEmpty()) {
                    for (Product p : products) { %>
                    <div class="col-sm-6 col-lg-4">
                        <div class="product-card position-relative">
                            <!-- Wishlist -->
                            <form method="post" action="${pageContext.request.contextPath}/wishlist">
                                <input type="hidden" name="productId" value="<%=p.getId()%>">
                                <button type="submit" class="wishlist-btn"><i class="fa fa-heart text-danger"></i></button>
                            </form>

                            <!-- Image -->
                            <img src="<%=request.getContextPath() + "/product-image?id=" + p.getId()%>"
                                 class="card-img-top mb-2" alt="<%=p.getProductName()%>">

                            <!-- Product Info -->
                            <h6 class="fw-bold text-dark mb-0"><%=p.getProductName()%></h6>
                            <p class="text-muted small mb-1"><%=p.getBrand()%> • <%=p.getCategory()%></p>

                            <div class="mb-1">
                                <span class="badge bg-info text-dark me-1"><%=p.getRam()%> GB RAM</span>
                                <span class="badge bg-secondary"><%=p.getColor()%></span>
                            </div>

                            <!-- Price -->
                            <div class="mb-1">
                                <span class="price">₹<%=Math.round(p.getDiscountedPrice())%></span>
                                <% if (p.getDiscountedPrice() < p.getPrice()) { %>
                                    <span class="old-price">₹<%=Math.round(p.getPrice())%></span>
                                    <span class="discount"><%= Math.round((1 - p.getDiscountedPrice() / p.getPrice()) * 100) %>% OFF</span>
                                <% } %>
                            </div>

                            <!-- Rating -->
                            <div class="rating mb-2">⭐ <%=String.format("%.1f", p.getRating())%></div>

                            <!-- Buttons -->
                            <div class="d-flex gap-2 mt-1">
                                <form method="post" action="${pageContext.request.contextPath}/add-to-cart" class="w-50">
                                    <input type="hidden" name="productId" value="<%=p.getId()%>">
                                    <button class="btn btn-success btn-sm w-100"><i class="fa fa-cart-plus me-1"></i>Add</button>
                                </form>
                                <form method="post" action="${pageContext.request.contextPath}/buy-now" class="w-50">
                                    <input type="hidden" name="productId" value="<%=p.getId()%>">
                                    <button class="btn btn-primary btn-sm w-100"><i class="fa fa-bolt me-1"></i>Buy</button>
                                </form>
                            </div>
                        </div>
                    </div>
                <% } } else { %>
                    <div class="text-center text-muted mt-5">
                        <i class="fa fa-box-open fa-3x mb-2"></i>
                        <p>No products found.</p>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
