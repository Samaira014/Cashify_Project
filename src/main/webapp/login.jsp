<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
	String message = (String) request.getAttribute("msg");
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center">
  <div class="row w-100 justify-content-center">
    <div class="col-12 col-sm-8 col-md-6 col-lg-4">
      <div class="card shadow-lg rounded-4 border-0">
        <div class="card-body p-4">
          <h3 class="text-center mb-4 fw-bold">Login</h3>

          <!-- Login Form -->
          <form action="login" method="post">
          
          <%if(message != null){ %>
          <h5 style="color: red;"><%=message%></h5>
          <%} %>
          
            
            <!-- Email -->
            <div class="mb-3">
              <label for="email" class="form-label fw-semibold">Email address</label>
              <input type="email" class="form-control form-control-lg" id="email" name="email" placeholder="Enter email" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
              <label for="password" class="form-label fw-semibold">Password</label>
              <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Enter password" required>
            </div>

            <!-- Role -->
            <div class="mb-3">
              <label for="role" class="form-label fw-semibold">Login As</label>
              <select class="form-select form-select-lg" id="role" name="role" required>
                <option value="" disabled selected>Choose role</option>
                <option value="admin">Admin</option>
                <option value="user">User</option>
                <option value="deliveryperson">Delivery Person</option>
                <option value="seller">Seller</option>
              </select>
            </div>

            <!-- Submit -->
            <div class="d-grid">
              <button type="submit" class="btn btn-primary btn-lg">Login</button>
            </div>

            <!-- Extra Links -->
            <div class="text-center mt-3">
              <p class="fs-6">Don't have an account? 
                <a href="registration.jsp" class="text-decoration-none">Register here</a>
              </p>
            </div>

          </form>
          <!-- End Form -->

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
