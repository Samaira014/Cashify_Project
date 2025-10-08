<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>

/* Card animation */
.card {
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    transform: translateY(50px);
    opacity: 0;
    animation: slideUp 1s ease forwards;
}

/* Card body */
.card-body {
    padding: 2.5rem;
}

/* Headings */
h3 {
    font-weight: 600;
    color: #333;
    text-align: center;
    margin-bottom: 2rem;
}

/* Inputs */
.form-control, .form-select {
    border-radius: 10px;
    padding: 0.75rem;
    transition: all 0.3s ease;
}

.form-control:focus, .form-select:focus {
    box-shadow: 0 0 12px rgba(37,117,252,0.5);
    border-color: #2575fc;
}

/* Buttons */
.btn-primary {
    background: linear-gradient(90deg, #6a11cb, #2575fc);
    border: none;
    border-radius: 12px;
    font-weight: 600;
    padding: 0.85rem;
    transition: all 0.3s ease;
    animation: pulse 2.5s infinite;
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(37, 117, 252, 0.4);
}

/* Animations */
@keyframes slideUp {
    0% { transform: translateY(50px); opacity: 0; }
    100% { transform: translateY(0); opacity: 1; }
}

@keyframes pulse {
    0% { box-shadow: 0 0 0 rgba(37,117,252,0.4); }
    50% { box-shadow: 0 0 12px rgba(37,117,252,0.7); }
    100% { box-shadow: 0 0 0 rgba(37,117,252,0.4); }
}
</style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg">
        <div class="card-body">
          <h3>Registration Form</h3>
          
          <form action="register" method="post">
            <div class="mb-3">
              <label for="id" class="form-label">ID</label>
              <input type="text" class="form-control" id="id" name="id" placeholder="Enter ID" required>
            </div>

            <div class="mb-3">
              <label for="name" class="form-label">Full Name</label>
              <input type="text" class="form-control" id="name" name="name" placeholder="Enter full name" required>
            </div>

            <div class="mb-3">
              <label for="email" class="form-label">Email address</label>
              <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
            </div>

            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
            </div>

            <div class="mb-3">
              <label for="phone" class="form-label">Phone</label>
              <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number" required>
            </div>

            <div class="mb-3">
              <label for="role" class="form-label">Select Role</label>
              <select class="form-select" id="role" name="role" required>
                <option value="" disabled selected>Choose role</option>
                <option value="admin">Admin</option>
                <option value="user">User</option>
                <option value="delivery">Delivery Person</option>
                <option value="seller">Seller</option>
              </select>
            </div>

            <div class="d-grid">
              <button type="submit" class="btn btn-primary btn-lg">Register</button>
            </div>
          </form>

        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
