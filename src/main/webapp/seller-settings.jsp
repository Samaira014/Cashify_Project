<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    background: linear-gradient(135deg, #f5f7fa, #c3cfe2, #f5f7fa);
    background-size: 400% 400%;
    animation: bgMove 15s ease infinite;
    min-height: 100vh;
    overflow-x: hidden;
}

@keyframes bgMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Sidebar */
.sidebar {
    background: #fff;
    padding: 20px;
    min-height: 100vh;
    animation: slideInLeft 0.8s ease forwards;
    box-shadow: 2px 0 8px rgba(0,0,0,0.05);
}
.sidebar a {
    display: block;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    padding: 12px 15px;
    border-radius: 8px;
    margin-bottom: 8px;
    transition: 0.3s;
}
.sidebar a:hover, .sidebar a.active {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    color: #fff;
    transform: translateX(5px);
}
@keyframes slideInLeft {
    0% { opacity: 0; transform: translateX(-40px); }
    100% { opacity: 1; transform: translateX(0); }
}

/* Card */
.card {
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    transform: translateY(50px);
    opacity: 0;
    animation: fadeInUp 0.8s ease forwards;
}
@keyframes fadeInUp {
    0% { opacity: 0; transform: translateY(50px); }
    100% { opacity: 1; transform: translateY(0); }
}

/* Gradient heading */
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

/* Input & buttons */
input.form-control:hover, input.form-control:focus {
    border-color: #ff6a00;
    box-shadow: 0 0 8px rgba(255,106,0,0.3);
    transition: 0.3s;
}
button.btn-primary { background: linear-gradient(90deg, #ff6a00, #ee0979); border: none; border-radius: 10px; transition: 0.3s; }
button.btn-primary:hover { transform: scale(1.05); }
button.btn-danger { border-radius: 10px; transition: 0.3s; }
button.btn-danger:hover { transform: scale(1.05); background-color: #d90429; border-color: #d90429; }

/* Profile image */
img#preview {
    max-width: 130px;
    border-radius: 50%;
    margin-top: 10px;
    display: none;
    opacity: 0;
    transition: opacity 0.6s ease, transform 0.6s ease;
}
img#preview.show { display: block; opacity: 1; transform: scale(1.05); }

/* Responsive */
@media (max-width: 768px) { .sidebar { display: none; } }
</style>
</head>
<body>

<jsp:include page="seller-navbar.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 sidebar">
            <a href="seller-home.jsp"><i class="bi bi-house-door"></i> Dashboard</a>
            <a href="seller-added-items.jsp"><i class="bi bi-plus-circle"></i> Sell a Phone</a>
            <a href="seller-listing.jsp"><i class="bi bi-phone"></i> My Listings</a>
            <a href="seller-sales-report.jsp"><i class="bi bi-bar-chart"></i> Sales Report</a>
            <a href="seller-settings.jsp" class="active"><i class="bi bi-gear"></i> Settings</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-6 offset-md-1 my-5">
            <div class="card p-4 bg-white">
                <h3 class="text-center mb-4 text-gradient">Seller Settings</h3>

                <% if (session.getAttribute("successMsg") != null) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    <%= session.getAttribute("successMsg") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMsg"); } %>

                <% if (session.getAttribute("errorMsg") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show">
                    <%= session.getAttribute("errorMsg") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMsg"); } %>

                <!-- Edit Button -->
                <div class="d-flex justify-content-end mb-3">
                    <button type="button" class="btn btn-outline-primary me-2" id="editBtn">
                        <i class="bi bi-pencil"></i> Edit
                    </button>
                </div>

                <form action="<%=request.getContextPath()%>SellerSettingsController" method="post" enctype="multipart/form-data" id="settingsForm" onsubmit="return validateForm()">
                    <!-- Row 1: Name + Email -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control form-control-sm" id="fullName" name="fullName" value="<%= seller.getName() %>" readonly required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control form-control-sm" id="email" name="email" value="<%= seller.getEmail() %>" readonly required>
                        </div>
                    </div>

                    <!-- Row 2: Phone + Password -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control form-control-sm" id="phone" name="phone" value="<%= seller.getPhone() %>" readonly required>
                        </div>
                        <div class="col-md-6 position-relative">
                            <label for="password" class="form-label">Password <small>(leave blank to keep current)</small></label>
                            <input type="password" class="form-control form-control-sm" id="password" name="password" readonly>
                            <i class="bi bi-eye-fill position-absolute top-50 end-0 translate-middle-y me-4 mt-3" style="cursor: pointer;" id="togglePassword"></i>
                        </div>
                    </div>

                    <!-- Row 3: Profile Image -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="profilePic" class="form-label">Profile Picture</label>
                            <input type="file" class="form-control form-control-sm" id="profilePic" name="profilePic" accept="image/*" onchange="previewImage(event)" disabled>
                            <img id="preview" src="#" alt="Profile Preview">
                        </div>
                    </div>

                    <!-- Buttons Row -->
                    <div class="d-flex justify-content-between align-items-center">
                        <button type="submit" class="btn btn-success" id="updateBtn" disabled>
                            <i class="bi bi-save"></i> Update
                        </button>

                        <button type="button" class="btn btn-danger" id="deleteBtn">
                            <i class="bi bi-trash"></i> Delete Account
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('editBtn').addEventListener('click', function() {
    document.querySelectorAll('#settingsForm input').forEach(input => input.removeAttribute('readonly'));
    document.getElementById('profilePic').removeAttribute('disabled');
    document.getElementById('updateBtn').removeAttribute('disabled');
});

// Toggle password visibility
const togglePassword = document.getElementById('togglePassword');
const passwordInput = document.getElementById('password');
togglePassword.addEventListener('click', () => {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    togglePassword.classList.toggle('bi-eye-slash-fill');
});

// Delete account confirmation
document.getElementById('deleteBtn').addEventListener('click', function() {
    if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
    	window.location.href = 'SellerDeleteAccountController?sellerId=<%= seller.getId() %>';
    }
});

// Image preview
function previewImage(event) {
    const preview = document.getElementById('preview');
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.classList.add('show');
        }
        reader.readAsDataURL(file);
    }
}

// Form validation
function validateForm() {
    const phone = document.getElementById('phone').value.trim();
    if (!/^\d{10,15}$/.test(phone)) {
        alert('Please enter a valid phone number (10-15 digits).');
        return false;
    }
    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
