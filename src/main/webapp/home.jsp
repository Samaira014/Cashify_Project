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
/* ==== Carousel Captions ==== */
.carousel {
	margin-left: 2px;
	margin-right: 2px;
	margin-top: 2px;
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

.d-block {
	height: 400px;
}

/*-------------Our Service Start here-------------------*/

/* Section */
.services-section {
	padding: 60px 15px;
	background: #f8faff;
	text-align: center;
}

.services-section h2 {
	font-size: 2rem;
	font-weight: 700;
	color: #0d6efd;
	margin-bottom: 40px;
	position: relative;
	display: table;
}

.services-section h2::after {
	content: "";
	width: 50%;
	height: 3px;
	background: #0d6efd;
	position: absolute;
	bottom: -10px;
	left: 25%;
	border-radius: 2px;
}

/* Card Style */
.device-card {
	background: #ffffff;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 20px 10px;
	text-align: center;
	transition: all 0.5s ease, transform 0.5s ease, opacity 0.5s ease;
	cursor: pointer;
	height: 160px;
	opacity: 0;
	transform: translateY(30px);
	animation: fadeUp 0.6s forwards;
}

.device-card:nth-child(1) {
	animation-delay: 0s;
}

.device-card:nth-child(2) {
	animation-delay: 0.1s;
}

.device-card:nth-child(3) {
	animation-delay: 0.2s;
}

.device-card:nth-child(4) {
	animation-delay: 0.3s;
}

.device-card:nth-child(5) {
	animation-delay: 0.4s;
}

.device-card:nth-child(6) {
	animation-delay: 0.5s;
}

@
keyframes fadeUp {to { opacity:1;
	transform: translateY(0);
}

}
.device-card:hover {
	transform: translateY(-6px) scale(1.05);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
	background: linear-gradient(135deg, #e9f0ff, #ffffff);
}

.device-card img {
	width: 88%;
	height: 90px;
	object-fit: contain;
	transition: transform 0.3s ease;
}

.device-card:hover img {
	transform: scale(1.2);
}

.device-title {
	font-size: 14px;
	font-weight: 600;
	color: #333;
	margin-top: 12px;
}

/* Responsive grid */

/* Desktop / Large screen: 8 per row */
.col-custom {
	flex: 0 0 12.5%; /* 100 / 8 = 12.5% */
	max-width: 12.5%;
}

/* Large tablets / laptops */
@media ( max-width : 1200px) {
	.col-custom {
		flex: 0 0 25%; /* 4 per row */
		max-width: 25%;
	}
}

/* Tablets / smaller desktops */
@media ( max-width : 992px) {
	.col-custom {
		flex: -1 0 33.33%; /* 3 per row */
		max-width: 33.33%;
	}
}

/* Phones */
@media ( max-width : 576px) {
	.col-custom {
		flex: 0 0 25%; /* 4 per row on small screens */
		max-width: 25%;
	}
	.device-card {
		height: 140px;
	}
	.device-title {
		font-size: 14px;
	}
}

/* Card Hover Effect */
.cart {
	font-size: 2rem;
	color: #0d6efd;
}

.custom-card {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer;
}

.custom-card:hover {
	transform: translateY(-8px) scale(1.03);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.img-box {
	width: 100%;
	height: 120px; /* fix uniform height */
	display: flex;
	justify-content: center;
	align-items: center;
	background: #f9f9f9; /* light background */
	border-radius: 12px 12px 0 0;
	overflow: hidden;
}

.img-box img {
	max-height: 100px;
	max-width: 100px;
	object-fit: contain; /* keeps aspect ratio */
}

/* Product Card Styling */
.product-card {
	border-radius: 12px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product-card:hover {
	transform: translateY(-5px) scale(1.03);
	box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
}

.product-img-box {
	background: #f8f8f8;
	padding: 15px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 12px 12px 0 0;
	height: 166px;
}

.product-img-box img {
	max-height: 100px;
	max-width: 100%;
	object-fit: contain;
}

.fw-medium {
	font-weight: 500; /* lighter than semi-bold */
}

/* Wishlist Heart Button */
.wishlist-btn {
	z-index: 10;
	font-size: 1rem;
}

/* Rating Stars */
.rating i {
	font-size: 0.85rem;
}

/* Badge */
.badge {
	font-size: 0.7rem;
	padding: 0.35em 0.5em;
}

/* Add to Cart Button */
.btn-primary {
	font-size: 0.8rem;
	padding: 0.35rem 0.5rem;
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
				<img src="./images/carousel8.jpg" class="d-block w-100"
					alt="Slide 1">
				<div class="carousel-caption d-none d-md-block">
					<h5>Sell & Buy with Cashify</h5>
					<p>Smart solutions for your gadgets, phones, and recycling
						needs.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="./images/carousel9.jpg" class="d-block w-100"
					alt="Slide 2">
				<div class="carousel-caption d-none d-md-block">
					<h5>Find Stores Near You</h5>
					<p>Locate trusted Cashify partners around you.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="./images/carousel10.jpg" class="d-block w-100"
					alt="Slide 3">
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

	<!-- -----------Our Service----------------------- -->

	<section class="services-section">
		<div class="container">
			<h2>Our Services</h2>
			<div class=" row  g-4 justify-content-center">
				<div class="col-custom ">
					<div class="device-card">
						<img src="./images/special-offer.jpg" alt="Offers">
						<div class="device-title">Offers</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<a href="sell_phone.jsp" class="text-decoration-none"> 
						<img src="./images/sell-phone.jpg" alt="Sell Phone">
						</a>
						<div class="device-title">Sell Phone</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<a href="gadgets.jsp" class="text-decoration-none">
							<img src="./images/gadgets.jpg" alt="Buy Gadgets">
							</a>	
					<div class="device-title">Buy Gadgets</div>
				 </div>
				</div>
				
				<div class="col-custom">
					<div class="device-card">
						<a href="phone-brand.jsp" class="text-decoration-none">
							<img src="./images/Apple-iPhone.jpg" alt="Buy Phone">
						</a>
						<div class="device-title">Buy Phone</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<img src="./images/laptop.jpg" alt="Buy Laptop">
						<div class="device-title">Buy Laptop</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<img src="./images/smartwatch.jpg" alt="Buy Smartwatch">
						<div class="device-title">Buy Smartwatches</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<img src="./images/shop.jpg" alt="Repair Laptop">
						<div class="device-title">Nearby Stores</div>
					</div>
				</div>
				<div class="col-custom">
					<div class="device-card">
						<img src="./images/recycle.jpg" alt="Repair Laptop">
						<div class="device-title">Recycle</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!-- Sell Your Old Device Now -->
	<div class="container my-5">
		<h4 class="mb-4 fw-bold cart">Sell Your Old Device Now</h4>
		<div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 g-4">

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Sell Phone">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell Phone</h6>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="./images/laptop.jpg" alt="Sell Laptop">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell Laptop</h6>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="./images/tv.jpg" alt="Sell TV">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell TV</h6>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="./images/tablet.jpg" alt="Sell Tablet">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell Tablet</h6>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="./images/smartwatch.jpg" alt="Sell Smartwatch">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell Smartwatch</h6>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 shadow-sm border-0 custom-card">
					<div class="img-box">
						<img src="images/speaker.jpg" alt="Sell Smart Speaker">
					</div>
					<div class="card-body text-center">
						<h6 class="fw-medium">Sell Smart Speakers</h6>
					</div>
				</div>
			</div>

		</div>
	</div>



	<!-- Buy Refurbished Devices -->
	<div class="container my-5">
		<h4 class="mb-4 fw-bold cart">Buy Refurbished Devices</h4>
		<div class="row g-3 justify-content-start">
			<!-- Single Product Card -->
			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>

			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>

			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/samsung-galaxy-s24.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/galaxyS24.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Buy Refurbished Devices -->
	<div class="container my-5">
		<h4 class="mb-4 fw-bold cart">Refurbished Laptops</h4>
		<div class="row g-3 justify-content-start">
			<!-- Single Product Card -->
			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/laptop.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>

			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>

			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/Apple-iPhone.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>


			<div class="col-6 col-md-4 col-lg-3 col-xl-2">
				<div
					class="card h-100 shadow-sm border-0 product-card position-relative">

					<!-- Wishlist Heart -->
					<button
						class="wishlist-btn position-absolute top-0 end-0 m-2 border-0 bg-white rounded-circle p-1">
						<i class="fa-regular fa-heart text-danger"></i>
					</button>

					<!-- Badge -->
					<span class="badge bg-success position-absolute top-0 start-0 m-2">Refurbished</span>

					<!-- Product Image -->
					<div class="product-img-box">
						<img src="./images/laptop.jpg" alt="Google Pixel 8a">
					</div>

					<!-- Card Body -->
					<div class="card-body text-center py-2">
						<h6 class="fw-medium mb-1">Google Pixel 8a</h6>
						<p class="text-muted mb-1">
							<del>₹57,799</del>
						</p>
						<h6 class="text-success fw-bold mb-1">₹23,399</h6>

						<!-- Rating -->
						<div class="rating mb-1">
							<i class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star text-warning"></i> <i
								class="fa-solid fa-star-half-stroke text-warning"></i> <i
								class="fa-regular fa-star text-warning"></i>
						</div>

						<!-- Add to Cart Button -->
						<button class="btn btn-sm btn-primary w-100">Buy Now</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
		
	</script>
</body>
</html>
