<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product"%>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products == null) products = new ArrayList<>();

    List<String> brands = (List<String>) request.getAttribute("brands");
    if (brands == null) brands = new ArrayList<>();

    List<String> categories = (List<String>) request.getAttribute("categories");
    if (categories == null) categories = new ArrayList<>();

    List<Integer> ramOptions = (List<Integer>) request.getAttribute("ramOptions");
    if (ramOptions == null) ramOptions = new ArrayList<>();

    List<String> colorOptions = (List<String>) request.getAttribute("colorOptions");
    if (colorOptions == null) colorOptions = new ArrayList<>();

    String selectedSort = (String) request.getAttribute("selectedSort");
    String searchQuery = (String) request.getAttribute("searchQuery");

    List<String> selectedBrands = (List<String>) request.getAttribute("selectedBrands");
    if (selectedBrands == null) selectedBrands = new ArrayList<>();

    List<String> selectedCategories = (List<String>) request.getAttribute("selectedCategories");
    if (selectedCategories == null) selectedCategories = new ArrayList<>();

    List<Integer> selectedRams = (List<Integer>) request.getAttribute("selectedRams");
    if (selectedRams == null) selectedRams = new ArrayList<>();

    List<String> selectedColors = (List<String>) request.getAttribute("selectedColors");
    if (selectedColors == null) selectedColors = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Phone Store - Dynamic with Images</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

@keyframes pageFadeIn { from {opacity:0;} to {opacity:1;} }

.sidebar {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.08);
    position: sticky;
    top: 20px;
    max-height: 90vh;
    overflow-y: auto;
    opacity: 0;
    transform: translateY(10px);
    animation: sidebarFadeIn 0.4s ease forwards;
}
@keyframes sidebarFadeIn { from {opacity:0; transform:translateY(10px);} to {opacity:1; transform:translateY(0);} }
.sidebar h6 { font-weight:600; margin-top:15px; margin-bottom:10px; color:#333; }
.form-check { margin-bottom:8px; }

.card {
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    overflow: hidden;
    background: #fff;
    opacity: 0;
    transform: translateY(15px);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    animation: cardFadeIn 0.4s ease forwards;
}
.card:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.12); }
@keyframes cardFadeIn { from {opacity:0; transform:translateY(15px);} to {opacity:1; transform:translateY(0);} }

.card img {
    height: 180px;
    object-fit: cover;
    width: 100%;
    opacity: 0;
    animation: imageFadeIn 0.5s ease forwards;
}
@keyframes imageFadeIn { from {opacity:0;} to {opacity:1;} }

.card-title { font-weight:600; font-size:0.95rem; }
.price { font-weight:600; color:#222; }
.price del { color:#888; margin-left:5px; }
.discount-badge { position:absolute; top:10px; left:10px; background:#ff6f61; color:#fff; font-size:12px; padding:2px 6px; border-radius:4px; opacity:0.9; }

.heart { position:absolute; top:10px; right:10px; font-size:18px; color:#bbb; cursor:pointer; transition: transform 0.2s ease, color 0.2s ease; }
.heart.active { color:#e63946; transform: scale(1.2); }

.btn { transition: transform 0.2s ease, box-shadow 0.2s ease; }
.btn:hover { transform: scale(1.03); box-shadow: 0 3px 8px rgba(0,0,0,0.15); }

.sort-bar { display:flex; justify-content:flex-end; margin-bottom:15px; }
.form-check-input { transition: transform 0.15s ease; }
.form-check-input:checked { transform: scale(1.05); }
</style>
</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container my-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-3 col-md-4 mb-4">
            <form method="get" action="products" class="sidebar">
                <h6>Search</h6>
                <input type="text" name="q" value="<%= searchQuery != null ? searchQuery : "" %>" class="form-control mb-3" placeholder="Search products">

                <h6>Brand</h6>
                <% for(String b: brands) { %>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="brand" value="<%=b%>" id="brand_<%=b%>"
                        <%= selectedBrands.contains(b) ? "checked" : "" %>>
                    <label class="form-check-label" for="brand_<%=b%>"><%=b%></label>
                </div>
                <% } %>

                <h6>Category</h6>
                <% for(String c: categories) { %>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="category" value="<%=c%>" id="cat_<%=c%>"
                        <%= selectedCategories.contains(c) ? "checked" : "" %>>
                    <label class="form-check-label" for="cat_<%=c%>"><%=c%></label>
                </div>
                <% } %>

                <h6>RAM</h6>
                <% for(Integer r: ramOptions) { %>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="ram" value="<%=r%>" id="ram_<%=r%>"
                        <%= selectedRams.contains(r) ? "checked" : "" %>>
                    <label class="form-check-label" for="ram_<%=r%>"><%=r%> GB</label>
                </div>
                <% } %>

                <h6>Color</h6>
                <% for(String c: colorOptions) { %>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="color" value="<%=c%>" id="color_<%=c%>"
                        <%= selectedColors.contains(c) ? "checked" : "" %>>
                    <label class="form-check-label" for="color_<%=c%>"><%=c%></label>
                </div>
                <% } %>

                <button type="submit" class="btn btn-primary mt-3 w-100">Apply Filters</button>
            </form>
        </div>

        <!-- Product Grid -->
        <div class="col-lg-9 col-md-8">
            <div class="sort-bar mb-3">
                <form method="get" action="products" class="d-flex">
                    <select name="sort" class="form-select w-auto" onchange="this.form.submit()">
                        <option value="">Sort By</option>
                        <option value="price_asc" <%= "price_asc".equals(selectedSort) ? "selected" : "" %>>Price: Low to High</option>
                        <option value="price_desc" <%= "price_desc".equals(selectedSort) ? "selected" : "" %>>Price: High to Low</option>
                    </select>
                </form>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <% for(Product p: products) { %>
                <div class="col">
                    <div class="card position-relative h-100">
                        <% if(p.getDiscountedPrice() != null && p.getDiscountedPrice() > 0) { %>
                        <div class="discount-badge">Offer</div>
                        <% } %>
                        <i class="fa-regular fa-heart heart"></i>
                        <img src="product-image?id=<%=p.getId()%>" alt="<%=p.getProductName()%>">
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title"><%=p.getBrand()%> <%=p.getProductName()%></h6>
                            <p class="card-text text-muted mb-1">RAM: <%=p.getRam()%> GB | Color: <%=p.getColor()%></p>
                            <p class="card-text text-muted mb-2">Model: <%=p.getModel()%> | Qty: <%=p.getQuantity()%></p>
                            <div class="price mb-2">
                                $<%=p.getDiscountedPrice() != null && p.getDiscountedPrice() > 0 ? p.getDiscountedPrice() : p.getPrice()%>
                                <% if(p.getDiscountedPrice() != null && p.getDiscountedPrice() > 0){ %>
                                <del>$<%=p.getPrice()%></del>
                                <% } %>
                            </div>
                            <div class="mt-auto d-flex gap-2">
                                <button class="btn btn-success btn-sm flex-fill">Buy Now</button>
                                <button class="btn btn-primary btn-sm flex-fill">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Heart toggle
document.querySelectorAll('.heart').forEach(icon => {
    icon.addEventListener('click', () => icon.classList.toggle('active'));
});

// Staggered animation for cards and images
window.addEventListener('load', () => {
    document.querySelectorAll('.card').forEach((card, index) => {
        card.style.animationDelay = `${index * 0.05}s`;
        let img = card.querySelector('img');
        img.style.animationDelay = `${index * 0.05 + 0.1}s`; // image fade slightly after card
    });
 // Get the filter form
    const filterForm = document.querySelector('.sidebar');

    // Listen to changes on checkboxes and sort dropdown
    filterForm.querySelectorAll('input[type="checkbox"]').forEach(input => {
        input.addEventListener('change', () => {
            filterForm.submit(); // Submit form automatically on checkbox change
        });
    });

    filterForm.querySelectorAll('select').forEach(select => {
        select.addEventListener('change', () => {
            filterForm.submit(); // Submit form automatically on sort change
        });
});
</script>
</body>
</html>
