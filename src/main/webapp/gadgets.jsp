<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Gadget Store</title>

  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <!-- Font Awesome -->
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
  />

  <style>
    body {
      background: #f8f9fa;
      font-family: 'Poppins', sans-serif;
    }
.g-4{
    margin-bottom: 40px;
    }
    .category-card {
      border-radius: 12px;
      overflow: hidden;
      background: white;
      box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
      transition: all 0.3s ease;
      cursor: pointer;
    }

    .category-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    .category-card img {
      width: 100%;
      height: 200px;
      object-fit: contain;
      padding: 15px;
      transition: transform 0.3s;
    }

    .category-card:hover img {
      transform: scale(1.08);
    }

    .category-card h5 {
      text-align: center;
      font-size: 1.1rem;
      color: #333;
      margin-bottom: 15px;
    }

    .page-title {
      text-align: center;
      margin: 3px 0 30px;
      font-weight: 600;
      color: #2c3e50;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <jsp:include page="header.jsp"></jsp:include>>

  <div class="container ">
    <h3 class="page-title">Our Latest Gadgets</h3>

    <div class="row g-4">
      <!-- Gadget Categories -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
      <a href="phone-brand.jsp" class="text-decoration-none">
        <div class="category-card">
          <img src="./images/giphone1.png" alt="Smartphone">
          <h5>Smartphones</h5>
        </div>
        </a>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/glaptop.jpg" alt="Laptop">
          <h5>Laptops</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/tablet.jpg" alt="Tablet">
          <h5>Tablets</h5>
        </div>
      </div>
      
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gtv.jpg" alt="Smart TV">
          <h5>Smart TVs</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gwatch.jpg" alt="Smart Watch">
          <h5>Smart Watches</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gheadphone.jpg" alt="Headphones">
          <h5>Headphones</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gspeaker.jpg" alt="Smart Speaker">
          <h5>Smart Speakers</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gconsole.jpg" alt="Gaming Console">
          <h5>Gaming Consoles</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gcamera.jpg" alt="Camera">
          <h5>Cameras</h5>
        </div>
      </div>

      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/gdrone.jpg" alt="Drone">
          <h5>Drones</h5>
        </div>
      </div>

    </div>
  </div>

  <!-- Footer -->
 <jsp:include page="footer.jsp"></jsp:include>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
