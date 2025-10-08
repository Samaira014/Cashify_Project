<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Phones | Gadget Store</title>

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
      background-color: #f8f9fa;
      font-family: 'Poppins', sans-serif;
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
      margin: 40px 0 20px;
      font-weight: 600;
      color: #2c3e50;
    }

    header {
      background: #0d6efd;
      color: white;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <jsp:include page="header.jsp"></jsp:include>

  <div class="container my-5">
    <h3 class="page-title">Explore Top Smartphone Brands</h3>

    <div class="row g-4">
      <!-- Apple -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/Apple-iPhone.jpg" alt="Apple iPhone">
          <h5>Apple</h5>
        </div>
      </div>

      <!-- Samsung -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="./images/samsung-galaxy-s24.jpg" alt="Samsung">
          <h5>Samsung</h5>
        </div>
      </div>

      <!-- OnePlus -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=OnePlus" alt="OnePlus">
          <h5>OnePlus</h5>
        </div>
      </div>

      <!-- Xiaomi -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Xiaomi+Mi" alt="Xiaomi">
          <h5>Xiaomi</h5>
        </div>
      </div>

      <!-- Realme -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Realme" alt="Realme">
          <h5>Realme</h5>
        </div>
      </div>

      <!-- Oppo -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Oppo" alt="Oppo">
          <h5>Oppo</h5>
        </div>
      </div>

      <!-- Vivo -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Vivo" alt="Vivo">
          <h5>Vivo</h5>
        </div>
      </div>

      <!-- Google Pixel -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Google+Pixel" alt="Google Pixel">
          <h5>Google Pixel</h5>
        </div>
      </div>

      <!-- Motorola -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Motorola" alt="Motorola">
          <h5>Motorola</h5>
        </div>
      </div>

      <!-- Nothing -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Nothing+Phone" alt="Nothing Phone">
          <h5>Nothing</h5>
        </div>
      </div>

      <!-- Nokia -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Nokia" alt="Nokia">
          <h5>Nokia</h5>
        </div>
      </div>

      <!-- Infinix -->
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="category-card">
          <img src="https://via.placeholder.com/300x200?text=Infinix" alt="Infinix">
          <h5>Infinix</h5>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
