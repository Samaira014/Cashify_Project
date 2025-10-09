<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seller Settings</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
    min-height: 100vh;
}

/* Card styling with entrance animation */
.card {
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    transform: translateY(-50px);
    opacity: 0;
    animation: fadeInUp 0.8s forwards;
}
@keyframes fadeInUp {
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

/* Heading gradient animation */
.text-gradient {
    background: linear-gradient(90deg, #ff6a00, #ee0979, #ff6a00);
    background-size: 200% 200%;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: gradientAnim 3s ease infinite;
    font-weight: 600;
}
@keyframes gradientAnim {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Inputs hover */
input.form-control:hover, input.form-control:focus {
    border-color: #ff6a00;
    box-shadow: 0 0 8px rgba(255,106,0,0.3);
    transition: 0.3s;
}

/* Buttons hover */
button.btn-primary:hover {
    background: #ff6a00;
    border-color: #ff6a00;
    transform: scale(1.03);
    transition: 0.3s;
}
button.btn-danger:hover {
    background: #ee0979;
    border-color: #ee0979;
    transform: scale(1.03);
    transition: 0.3s;
}

/* Profile image preview */
img#preview {
    max-width: 150px;
    border-radius: 50%;
    margin-top: 10px;
    display: none;
    opacity: 0;
    transition: opacity 0.6s ease-in-out, transform 0.6s ease;
}
img#preview.show {
    display: block;
    opacity: 1;
    transform: scale(1.05);
}
</style>
</head>
<body>

<jsp:include page="seller-navbar.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <h3 class="text-center mb-4 text-gradient">Seller Settings</h3>

                <!-- Success / Error Messages -->
                <% if (session.getAttribute("successMsg") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <%= session.getAttribute("successMsg") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("successMsg"); %>
                <% } %>
                <% if (session.getAttribute("errorMsg") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show">
                        <%= session.getAttribute("errorMsg") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("errorMsg"); %>
                <% } %>

                <form action="SellerSettingsController" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName"
                               value="<%= seller.getName() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email"
                               value="<%= seller.getEmail() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone"
                               value="<%= seller.getPhone() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password <small>(leave blank to keep current)</small></label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>

                    <!-- Profile Picture -->
                    <div class="mb-3">
                        <label for="profilePic" class="form-label">Profile Picture</label>
                        <input type="file" class="form-control" id="profilePic" name="profilePic" accept="image/*" onchange="previewImage(event)">
                        <img id="preview" src="#" alt="Profile Preview">
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Update Settings
                        </button>
                    </div>
                </form>

                <!-- Delete Account -->
                <form action="SellerDeleteController" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.')">
                    <input type="hidden" name="sellerId" value="<%= seller.getId() %>">
                    <button type="submit" class="btn btn-danger w-100">
                        <i class="bi bi-trash"></i> Delete Account
                    </button>
                </form>

            </div>
        </div>
    </div>
</div>

<script>
function validateForm() {
    const phone = document.getElementById('phone').value.trim();
    if (!/^\d{10,15}$/.test(phone)) {
        alert('Please enter a valid phone number (10-15 digits).');
        return false;
    }
    return true;
}

function previewImage(event) {
    const preview = document.getElementById('preview');
    const file = event.target.files[0];

    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.classList.add('show'); // fade-in animation
        }
        reader.readAsDataURL(file);
    }
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
