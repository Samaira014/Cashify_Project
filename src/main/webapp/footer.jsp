<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer</title>
<!-- Custom CSS for hover animation -->
<style>
html, body {
	height: 100%;
}

body {
	display: flex;
	flex-direction: column;
}

footer {
	margin-top: auto;
}

.footer-link {
	color: #bbb;
	text-decoration: none;
	display: block;
	padding: 4px 0;
	transition: color 0.3s ease, transform 0.2s ease;
}

.footer-link:hover {
	color: #0d6efd;
	transform: translateX(6px);
}

.social-icon {
	transition: all 0.3s ease;
}

.social-icon:hover {
	background-color: #0d6efd;
	border-color: #0d6efd;
	transform: translateY(-3px) scale(1.1);
}

form input[type="email"] {
	border-radius: 20px;
}

form button {
	border-radius: 20px;
}
</style>

</head>
<body>

	<!-- AOS CSS -->
	<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />

	<footer class="bg-dark text-light pt-5 mt-auto">
		<div class="container">
			<div class="row text-center text-md-start">

				<!-- Brand / About -->
				<div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="100">
					<h3 class="fw-bold text-primary">Cashify</h3>
					<p class="small text-muted">Turning your old devices into
						instant cash. Buy, sell, recycle, and repair with ease.</p>
					<div class="d-flex justify-content-center justify-content-md-start">
						<a href="#"
							class="btn btn-outline-light btn-sm rounded-circle me-2 social-icon">
							<i class="fab fa-facebook-f"></i>
						</a> <a href="#"
							class="btn btn-outline-light btn-sm rounded-circle me-2 social-icon">
							<i class="fab fa-twitter"></i>
						</a> <a href="#"
							class="btn btn-outline-light btn-sm rounded-circle me-2 social-icon">
							<i class="fab fa-instagram"></i>
						</a> <a href="#"
							class="btn btn-outline-light btn-sm rounded-circle social-icon">
							<i class="fab fa-linkedin-in"></i>
						</a>
					</div>
				</div>

				<!-- Quick Links -->
				<div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="200">
					<h5 class="fw-bold">Quick Links</h5>
					<ul class="list-unstyled">
						<li><a href="index.jsp" class="footer-link">Home</a></li>
						<li><a href="features.jsp" class="footer-link">Features</a></li>
						<li><a href="services.jsp" class="footer-link">Services</a></li>
						<li><a href="login.jsp" class="footer-link">Login</a></li>
						<li><a href="register.jsp" class="footer-link">Register</a></li>
					</ul>
				</div>

				<!-- Resources -->
				<div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="300">
					<h5 class="fw-bold">Resources</h5>
					<ul class="list-unstyled">
						<li><a href="#" class="footer-link">Help Center</a></li>
						<li><a href="#" class="footer-link">Privacy Policy</a></li>
						<li><a href="#" class="footer-link">Terms of Service</a></li>
						<li><a href="#" class="footer-link">FAQs</a></li>
					</ul>
				</div>

				<!-- Newsletter -->
				<div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="400">
					<h5 class="fw-bold">Stay Updated</h5>
					<p class="small">Subscribe to our newsletter for the latest
						deals.</p>
					<form class="d-flex">
						<input type="email" class="form-control form-control-sm me-2"
							placeholder="Your email">
						<button type="submit" class="btn btn-primary btn-sm">Subscribe</button>
					</form>
				</div>
			</div>

			<!-- Copyright -->
			<div class="text-center border-top border-secondary mt-4 pt-3 pb-2"
				data-aos="fade-in">
				<p class="mb-0 small">
					&copy;
					<%=java.time.Year.now()%>
					Cashify. All Rights Reserved.
				</p>
			</div>
		</div>
	</footer>

	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
	<script>
		AOS.init({
			duration : 800, // animation duration
			once : true, // run only once when scrolled
			offset : 50
		// trigger point
		});
	</script>

</body>
</html>