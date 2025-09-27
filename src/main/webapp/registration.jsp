<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp"></jsp:include>

  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="card shadow-lg rounded-4">
          <div class="card-body p-4">
            <h3 class="text-center mb-4">Registration Form</h3>
            
            <!-- Form starts -->
            <form action="register" method="get">
              
              <!-- ID -->
              <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" name="id" placeholder="Enter ID" required>
              </div>

              <!-- Name -->
              <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter full name" required>
              </div>

              <!-- Email -->
              <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
              </div>

              <!-- Password -->
              <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
              </div>

              <!-- Phone -->
              <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number" required>
              </div>

              <!-- Role -->
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

              <!-- Submit -->
              <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">Register</button>
              </div>

            </form>
            <!-- Form ends -->

          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
