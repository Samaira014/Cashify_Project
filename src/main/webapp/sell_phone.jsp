<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sell Your Phone</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
<style>
    body {
        background: linear-gradient(135deg, #f8f9fa, #eef3f9);
    }
    .form-card {
        max-width: 900px;
        margin: 50px auto;
        padding: 30px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        animation: fadeInUp 1s ease;
    }
    .form-title {
        font-weight: bold;
        color: #0d6efd;
        margin-bottom: 25px;
        text-align: center;
        animation: slideDown 1s ease;
    }
    .btn-success {
        width: 100%;
        font-weight: 500;
        padding: 12px;
        border-radius: 30px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .btn-success:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    }
    .form-label {
        font-weight: 500;
    }

    /* Animations */
    @keyframes fadeInUp {
        0% { opacity: 0; transform: translateY(50px); }
        100% { opacity: 1; transform: translateY(0); }
    }
    @keyframes slideDown {
        0% { opacity: 0; transform: translateY(-30px); }
        100% { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>
<%
    HttpSession httpSession = request.getSession();
    if(httpSession.getAttribute("userSession") != null){
%>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container">
        <div class="form-card">
            <h2 class="form-title">📱 Sell Your Phone</h2>
            <form>
                <div class="row g-3">
                    <!-- Full Name -->
                    <div class="col-md-6">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter your full name" required>
                    </div>

                    <!-- Email -->
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
                    </div>

                    <!-- Phone -->
                    <div class="col-md-6">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" placeholder="Enter your phone number">
                    </div>

                    <!-- Brand -->
                    <div class="col-md-6">
                        <label for="brand" class="form-label">Brand</label>
                        <select class="form-select" id="brand" required>
                            <option selected disabled>Choose brand</option>
                            <option>Apple</option>
                            <option>Samsung</option>
                            <option>Xiaomi</option>
                            <option>OnePlus</option>
                            <option>Other</option>
                        </select>
                    </div>

                    <!-- Model -->
                    <div class="col-md-6">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" class="form-control" id="model" placeholder="Enter phone model" required>
                    </div>

                    <!-- Storage -->
                    <div class="col-md-6">
                        <label for="storage" class="form-label">Storage Capacity</label>
                        <select class="form-select" id="storage" required>
                            <option selected disabled>Choose storage</option>
                            <option>32 GB</option>
                            <option>64 GB</option>
                            <option>128 GB</option>
                            <option>256 GB</option>
                            <option>512 GB</option>
                        </select>
                    </div>

                    <!-- Condition -->
                    <div class="col-md-6">
                        <label for="condition" class="form-label">Condition</label>
                        <select class="form-select" id="condition" required>
                            <option selected disabled>Select condition</option>
                            <option>New</option>
                            <option>Like New</option>
                            <option>Good</option>
                            <option>Fair</option>
                            <option>Damaged</option>
                        </select>
                    </div>

                    <!-- Expected Price -->
                    <div class="col-md-6">
                        <label for="price" class="form-label">Expected Price ($)</label>
                        <input type="number" class="form-control" id="price" placeholder="Enter expected price" required>
                    </div>

                    <!-- Comments -->
                    <div class="col-12">
                        <label for="comments" class="form-label">Additional Comments</label>
                        <textarea class="form-control" id="comments" rows="3" placeholder="Write something about your phone"></textarea>
                    </div>

                    <!-- Image Upload -->
                    <div class="col-12">
                        <label for="image" class="form-label">Upload Phone Image</label>
                        <input class="form-control" type="file" id="image" accept="image/*">
                    </div>

                    <!-- Submit Button -->
                    <div class="col-12">
                        <button type="submit" class="btn btn-success mt-3">🚀 Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

<%
    } else {
        request.setAttribute("msg", "Please login with user then access it");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
