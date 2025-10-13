<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller" %>
<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sell Electronics | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #f0f0f5, #fff7f2);
    overflow-x: hidden;
    min-height: 100vh;
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
    box-shadow: 0 6px 15px rgba(0,0,0,0.15);
}
.sidebar a.active {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    color: #fff !important;
}

/* Page Heading */
.page-heading {
    text-align: center;
    margin: 30px 0;
    font-weight: 600;
    color: #e22d78;
    animation: fadeInDown 0.7s forwards;
}

/* Form Card */
.form-card {
    background: #fff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    transition: transform 0.4s, box-shadow 0.4s;
    animation: fadeInUp 0.7s forwards;
}
.form-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}

/* Form Elements */
.form-control, .form-select, textarea, input[list] {
    border-radius: 8px;
    margin-bottom: 15px;
    transition: all 0.3s;
}

/* Focus and Hover for inputs & selects */
.form-control:focus, 
.form-select:focus, 
textarea:focus, 
input[list]:focus {
    border-color: #ff6a00 !important; /* Orange theme */
    box-shadow: 0 0 10px rgba(255,106,0,0.3);
    outline: none; /* Remove default blue */
}
.form-control:hover, 
.form-select:hover, 
textarea:hover, 
input[list]:hover {
    border-color: #ff6a00;
}

/* Buttons */
.btn-submit {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    border: none;
    color: #fff;
    font-weight: 600;
    transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
}
.btn-submit:hover {
    transform: scale(1.1);
    box-shadow: 0 8px 25px rgba(255, 106, 0, 0.5);
    background: linear-gradient(90deg, #ee0979, #ff6a00);
}

/* Image Preview */
#imagePreview {
    display: none;
    max-width: 100%;
    margin-top: 15px;
    border-radius: 8px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    animation: fadeInUp 0.5s forwards;
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
</style>
</head>
<body>

<jsp:include page="seller-navbar.jsp"></jsp:include>

<div class="container-fluid mt-4">
  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3 sidebar">
        <a href="seller-home.jsp"><i class="bi bi-house-door-fill"></i> Dashboard</a>
        <a href="seller-added-items.jsp" class="active"><i class="bi bi-plus-circle"></i> Sell an Item</a>
        <a href="seller-listing.jsp"><i class="bi bi-phone"></i> My Listings</a>
        <a href="seller-sales-report.jsp"><i class="bi bi-graph-up"></i> Sales Reports</a>
        <a href="seller-settings.jsp"><i class="bi bi-gear-fill"></i> Settings</a>
    </div>

    <!-- Main Content -->
    <div class="col-md-9">
        
        <div class="form-card">
            <form action="SellerAddedItemController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="sellerId" value="<%= seller.getId() %>">

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="itemName" class="form-label">Item Name</label>
                        <input type="text" class="form-control" id="itemName" name="itemName" placeholder="Enter item name" required>
                    </div>
                    <div class="col-md-6">
                        <label for="category" class="form-label">Category</label>
                        <input list="categories" class="form-control" id="category" name="category" placeholder="Choose or type category" required>
                        <datalist id="categories">
                            <option value="Phone">
                            <option value="Tablet">
                            <option value="Laptop">
                            <option value="Watch">
                        </datalist>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="brand" class="form-label">Brand</label>
                        <input type="text" class="form-control" id="brand" name="brand" placeholder="Enter brand" required>
                    </div>
                    <div class="col-md-6">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" class="form-control" id="model" name="model" placeholder="Enter model" required>
                    </div>
                </div>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="ram" class="form-label">RAM</label>
                        <input type="text" class="form-control" id="ram" name="ram" placeholder="Enter ram" required>
                    </div>
                    <div class="col-md-6">
                        <label for="color" class="form-label">Color</label>
                        <input type="text" class="form-control" id="model" name="color" placeholder="Enter color" required>
                    </div> 
                  </div>  

                <div class="row g-3">
                	<div class="col-md-6">
                        <label for="brand" class="form-label">Quantity</label>
                        <input type="text" class="form-control" id="quantity" name="quantity" placeholder="Enter quantity" required>
                    </div>
                    <div class="col-md-6">
                        <label for="price" class="form-label">Price (₹)</label>
                        <input type="number" class="form-control" id="price" name="price" placeholder="Enter price" required>
                    </div>
                </div>
                
                <div class="row g-3">
                <div class="col-md-6">
                        <label for="condition" class="form-label">Condition</label>
                        <select class="form-select" id="condition" name="condition" required>
                            <option value="" selected disabled>Select condition</option>
                            <option value="New">New</option>
                            <option value="Used">Used</option>
                            <option value="Refurbished">Refurbished</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="image" class="form-label">Upload Image</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
                        <img id="imagePreview" src="#" alt="Image Preview">
                    </div>
                </div> 

                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Describe your item"></textarea>

                <div class="text-center mt-3">
				    <button type="submit" class="btn btn-submit w-25"><i class="bi bi-plus-circle"></i> Add Item</button>
				</div>
			</form>
        </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Image preview script
document.getElementById('image').addEventListener('change', function(event){
    const file = event.target.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = function(e){
            const preview = document.getElementById('imagePreview');
            preview.src = e.target.result;
            preview.style.display = 'block';
        }
        reader.readAsDataURL(file);
    }
});
</script>
</body>
</html>