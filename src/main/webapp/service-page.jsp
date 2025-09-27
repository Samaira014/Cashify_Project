<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Our Services - Cashify</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
   
    .service-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .service-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    .service-icon {
        font-size: 3rem;
        color: #0d6efd;
    }
</style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp"></jsp:include>

    <!-- Services Section -->
    <section class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold">Our Services</h1>
            <p class="text-muted">Explore the services we provide to make your life easier</p>
        </div>

        <div class="row g-4">
            <!-- Service 1 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h5 class="fw-bold">Mobile Buyback</h5>
                    <p class="text-muted">Sell your old smartphones at the best market price instantly.</p>
                </div>
            </div>
            <!-- Service 2 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-tools"></i>
                    </div>
                    <h5 class="fw-bold">Repair Services</h5>
                    <p class="text-muted">Quick and reliable repairs for mobiles, tablets, and laptops.</p>
                </div>
            </div>
            <!-- Service 3 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-recycle"></i>
                    </div>
                    <h5 class="fw-bold">Device Recycling</h5>
                    <p class="text-muted">Eco-friendly recycling options for your unused gadgets.</p>
                </div>
            </div>
            <!-- Service 4 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h5 class="fw-bold">Device Protection Plans</h5>
                    <p class="text-muted">Affordable protection plans for accidental and screen damages.</p>
                </div>
            </div>
            <!-- Service 5 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-hand-holding-usd"></i>
                    </div>
                    <h5 class="fw-bold">Instant Payments</h5>
                    <p class="text-muted">Get instant cash or bank transfer for your old devices.</p>
                </div>
            </div>
            <!-- Service 6 -->
            <div class="col-md-4">
                <div class="card service-card text-center p-4 h-100">
                    <div class="service-icon mb-3">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h5 class="fw-bold">Customer Support</h5>
                    <p class="text-muted">24/7 dedicated support to answer all your queries quickly.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
