<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cashify</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
/* Navbar Gradient + Shadow */
.navbar {
	background: linear-gradient(90deg, #0d6efd, #6610f2);
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
	padding: 0.6rem 1rem;
}

.navbar-brand {
	font-size: 1.8rem;
	font-weight: bold;
	color: #fff !important;
	letter-spacing: 1px;
}

.nav-link {
	color: #fff !important;
	font-weight: 500;
	padding: 0.4rem 0.6rem;
}

.nav-link:hover {
	color: #ffc107 !important;
}

.dropdown-menu {
	border-radius: 10px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

/* Search bar - modern style */
.navbar-search {
	position: relative;
	width: 320px;
	margin-left: 1rem;
	transition: all 0.3s ease;
	flex-shrink: 1;
	max-width: 280px;
}

.navbar-search input {
	width: 100%;
	max-width: 320px;
	padding: 0.5rem 1rem 0.5rem 2.8rem;
	border-radius: 0.5rem;
	border: 1px solid yellow;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.navbar-search input:focus {
	width: 380px;
	border-color: yellow;
	box-shadow: 0 0 15px rgba(255, 193, 7, 0.6);
}

.navbar-search .fa-magnifying-glass {
	position: absolute;
	top: 50%;
	left: 12px;
	transform: translateY(-50%);
	color: #666;
	pointer-events: none;
}

/* Login Dropdown */
.user-dropdown {
	color: #fff !important;
	display: flex;
	align-items: center;
	gap: 0.4rem;
	font-weight: 500;
	text-decoration: none;
}

.user-dropdown i {
	font-size: 1.2rem;
}

.dropdown-menu a i {
	margin-right: 8px;
}

/* Cart Icon */
.cart-icon {
	color: #fff;
	font-size: 1.2rem;
	margin-left: 1rem;
	position: relative;
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 0.3rem;
}

.cart-icon:hover {
	color: #ffc107;
}

/* Buttons */
.btn-login, .btn-register, .btn-logout {
	border-radius: 50px;
	font-weight: 600;
	padding: 0.35rem 1.2rem;
	margin-left: 0.5rem;
	border: none;
	transition: all 0.3s ease;
}

.sticky-top {
	position: sticky;
	top: 0;
	z-index: 1030;
}

/* Mobile App Style Navbar */
@media ( max-width : 992px) {
	.navbar-nav, .navbar-search, .d-flex.ms-auto {
		display: none;
	}
	.mobile-nav {
		position: fixed;
		bottom: 0;
		left: 0;
		width: 100%;
		background: linear-gradient(90deg, #0d6efd, #6610f2);
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding: 0.5rem 0;
		box-shadow: 0 -3px 10px rgba(0, 0, 0, 0.2);
		z-index: 1040;
	}
	.mobile-nav a {
		color: #fff;
		text-align: center;
		font-size: 0.9rem;
		display: flex;
		flex-direction: column;
		align-items: center;
		text-decoration: none;
	}
	.mobile-nav a:hover {
		color: #ffc107;
	}
	.mobile-nav i {
		font-size: 1.3rem;
		margin-bottom: 2px;
	}
}
</style>
</head>

<%
String adminSession = (String) session.getAttribute("adminSession");
String userSession = (String) session.getAttribute("userSession");
String loggedInUserName = (String) session.getAttribute("name");


%>

<body>

	<!-- Top Navbar -->
	<nav class="navbar navbar-expand-lg sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">💰 Cashify</a>

			<!-- Navbar links -->
			<ul class="navbar-nav me-2 mb-2 mb-lg-0 d-none d-lg-flex">
				<li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Features</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="servicesDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">Services</a>
					<ul class="dropdown-menu" aria-labelledby="servicesDropdown">
						<li><a class="dropdown-item" href="#">Loan Plans</a></li>
						<li><a class="dropdown-item" href="#">Investment</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">Consulting</a></li>
					</ul></li>
			</ul>

			<!-- Search bar -->
			<form class="navbar-search" action="search.jsp" method="get">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					name="query" placeholder="Search..." required>
			</form>

			<!-- Right Side: Login Dropdown + Cart -->
			<div class="d-flex align-items-center ms-auto d-none d-lg-flex">

				<!-- Login Dropdown (button trigger for reliability) -->
				<div class="dropdown">
					<button class="btn btn-transparent user-dropdown dropdown-toggle"
						type="button" id="userDropdownBtn" data-bs-toggle="dropdown"
						aria-expanded="false">
						<i class="fa-regular fa-user"></i> 
						<span> 
						<%= (loggedInUserName != null) ? loggedInUserName : "Login" %>
						</span>
					</button>

					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="userDropdownBtn">
						<%
						if (adminSession != null || userSession != null) {
						%>
						<li><a class="dropdown-item" href="user-profile.jsp"><i
								class="fa-solid fa-user me-2"></i> My Profile</a></li>
						<li><a class="dropdown-item" href="wishlist.jsp"><i
								class="fa-solid fa-heart me-2"></i> Wishlist</a></li>
						<li><a class="dropdown-item" href="orders.jsp"><i
								class="fa-solid fa-box me-2"></i> My Orders</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item text-danger" href="logout"><i
								class="fa-solid fa-right-from-bracket me-2"></i> Logout</a></li>
						<%
						} else {
						%>
						<li><a class="dropdown-item" href="login.jsp"><i
								class="fa-solid fa-right-to-bracket me-2"></i> Login</a></li>
						<li><a class="dropdown-item" href="registration.jsp"><i
								class="fa-solid fa-user-plus me-2"></i> Signup</a></li>
						<%
						}
						%>
					</ul>
				</div>

				<!-- Cart Icon -->
				<a href="cart.jsp" class="cart-icon ms-3"> <i
					class="fa-solid fa-cart-shopping"></i> <span>Cart</span>
				</a>

			</div>

		</div>
	</nav>

	<!-- Bottom Navbar for mobile -->
	<div class="mobile-nav d-lg-none">
		<a href="home.jsp"><i class="fa-solid fa-house"></i>Home</a> <a
			href="#"><i class="fa-solid fa-gear"></i>Features</a> <a href="#"><i
			class="fa-solid fa-hand-holding-dollar"></i>Services</a> <a
			href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i>Cart</a>
		<%
		if (adminSession != null || userSession != null) {
		%>
		<a href="logout"><i class="fa-solid fa-right-from-bracket"></i>Logout</a>
		<%
		} else {
		%>
		<a href="login.jsp"><i class="fa-solid fa-right-to-bracket"></i>Login</a>
		<%
		}
		%>
	</div>

	<!-- Bootstrap JS (must be the bundle) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-q2Dy+6k1+Up+jeEoQjBo3q8CNcMgcL0B9jpbGoxb8VvE8wH/vb5I9f6K4oF3xrBE"
crossorigin="anonymous"></script>

<script>
document.addEventListener('DOMContentLoaded', () => {
  // confirm Bootstrap loaded
  if (!window.bootstrap || !bootstrap.Dropdown) {
    console.error("Bootstrap JS not loaded!");
    return;
  }
  console.log("Bootstrap loaded ✅");

  // manually init all dropdowns
  document.querySelectorAll('.dropdown-toggle').forEach(el => {
    new bootstrap.Dropdown(el);
  });
});
</script>

</body>
</html>
