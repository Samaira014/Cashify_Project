<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home page</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
/* Carousel Captions */
.row {
	width: 90%;
}
.service-card img {
    width: auto;
    height: 138%;
    object-fit: contain;
    margin: 0 auto;
}

.carousel-caption h5 {
	font-size: 2rem;
	font-weight: 600;
	text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);
}

.carousel-caption p {
	font-size: 1.1rem;
	text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.4);
}

/* Service Section */
.services-section {
	padding: 60px 15px;
	background: linear-gradient(135deg, #f9fafc, #fff9f2);
	border-top: 2px solid #eee;
}

.services-section h2 {
	font-size: 2rem;
	font-weight: 700;
	color: #0d6efd;
	margin-bottom: 40px;
	position: relative;
	display: inline-block;
}

.services-section h2::after {
	content: "";
	width: 60%;
	height: 3px;
	background: #0d6efd;
	position: absolute;
	bottom: -10px;
	left: 20%;
	border-radius: 2px;
	animation: expand 1.5s ease-in-out infinite alternate;
}

@
keyframes expand {from { width:20%;
	
}

to {
	width: 60%;
}

}

/* Service Cards */
.service-card {
	background: #ffffff;
	border-radius: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	padding: 25px 15px;
	text-align: center;
	transition: all 0.3s ease;
	cursor: pointer;
	height: 140px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.service-card:hover {
	transform: translateY(-8px) scale(1.05);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.service-icon {
	font-size: 32px;
	color: #0d6efd;
	margin-bottom: 10px;
	transition: transform 0.4s ease, color 0.3s ease;
}

.service-card:hover .service-icon {
	transform: scale(1.3) rotate(12deg);
	color: #ff6f61;
}

.service-title {
	font-size: 16px;
	font-weight: 600;
	color: #333;
	margin-top: 8px;
}


.service-card:nth-child(1) {
	animation-delay: 0.2s;
}

.service-card:nth-child(2) {
	animation-delay: 0.4s;
}

.service-card:nth-child(3) {
	animation-delay: 0.6s;
}

.service-card:nth-child(4) {
	animation-delay: 0.8s;
}

.service-card:nth-child(5) {
	animation-delay: 1s;
}

.service-card:nth-child(6) {
	animation-delay: 1.2s;
}

.service-card:nth-child(7) {
	animation-delay: 1.4s;
}

.service-card:nth-child(8) {
	animation-delay: 1.6s;
}

@
keyframes fadeInUp {to { opacity:1;
	transform: translateY(0);
}

}

/* Responsive */
@media ( max-width : 768px) {
	.carousel-caption h5 {
		font-size: 1.3rem;
	}
	.carousel-caption p {
		font-size: 0.9rem;
	}
	.service-card {
		height: 110px;
	}
	.service-title {
		font-size: 14px;
	}
}
</style>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>

	<!-- Carousel -->
	<div id="carouselExampleCaptions" class="carousel slide">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="https://picsum.photos/1200/400?random=1"
					class="d-block w-100" alt="Slide 1">
				<div class="carousel-caption d-none d-md-block">
					<h5>Sell & Buy with Cashify</h5>
					<p>Smart solutions for your gadgets, phones, and recycling
						needs.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="https://picsum.photos/1200/400?random=2"
					class="d-block w-100" alt="Slide 2">
				<div class="carousel-caption d-none d-md-block">
					<h5>Find Stores Near You</h5>
					<p>Locate trusted Cashify partners around you.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="https://picsum.photos/1200/400?random=3"
					class="d-block w-100" alt="Slide 3">
				<div class="carousel-caption d-none d-md-block">
					<h5>Recycle Responsibly</h5>
					<p>Eco-friendly way to recycle your gadgets.</p>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>

	<!-- Our Services -->
	<section class="services-section">
		<div class="container">
			<h2 class="text-center">Our Services</h2>
			<div class="row g-3">
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/sell-phone.jpg"
							alt="Sell Phones">
					</div>
					<div class="service-title text-center">Sell Phones</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/gadgets.jpg"
							alt="Sell Phones" >				
								</div>
					<div class="service-title text-center">Buy Gadgets</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/shop.jpg"
							alt="Sell Phones" >
					</div>
					<div class="service-title text-center">Nearby Stores</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/recycle.jpg"
							alt="Sell Phones" >
					</div>
					<div class="service-title text-center">Recycle</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/repair.jpg"
							alt="Sell Phones">
					</div>
					<div class="service-title text-center">Repair Phone</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/exchange.jpg"
							alt="Sell Phones" >
					</div>
					<div class="service-title text-center">Exchange</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/special-offer.jpg"
							alt="Sell Phones" >
					</div>
					<div class="service-title text-center">Offers</div>
				</div>
				<div class="col-6 col-md-3">
					<div class="service-card">
						<img src="${pageContext.request.contextPath}/images/Apple-iPhone.jpg"
							alt="Sell Phones">
					</div>
					<div class="service-title text-center">Support</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
