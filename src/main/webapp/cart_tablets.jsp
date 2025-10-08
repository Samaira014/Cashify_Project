<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tablet Store with Filters</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body {
      background: #f5f7fa;
      font-family: 'Poppins', sans-serif;
    }

    /* Drawer / Sidebar Styles */
    .filter-drawer {
      position: fixed;
      top: 0;
      left: 0;
      width: 280px;
      height: 100%;
      background: #ffffff;
      box-shadow: 2px 0 12px rgba(0,0,0,0.1);
      transform: translateX(-100%);
      transition: transform 0.3s ease;
      z-index: 1050;
      overflow-y: auto;
    }
    .filter-drawer.open {
      transform: translateX(0);
    }
    .filter-header {
      padding: 1rem;
      border-bottom: 1px solid #eaeaea;
    }
    .filter-body {
      padding: 1rem;
    }
    .filter-footer {
      padding: 1rem;
      border-top: 1px solid #eaeaea;
      text-align: right;
    }
    .overlay {
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.4);
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease;
      z-index: 1040;
    }
    .overlay.show {
      opacity: 1;
      visibility: visible;
    }

    .card {
      border: none;
      border-radius: 12px;
      overflow: hidden;
      background: #fff;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
      transition: transform 0.3s, box-shadow 0.3s;
      position: relative;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }
    .card img {
      height: 200px;
      object-fit: cover;
    }
    .heart {
      position: absolute;
      top: 12px;
      right: 15px;
      font-size: 22px;
      color: #bbb;
      cursor: pointer;
      z-index: 10;
      transition: color 0.3s;
    }
    .heart.active {
      color: #e63946;
    }
    .rating {
      color: #f4b400;
      font-size: 15px;
    }
    .price {
      font-size: 1.1rem;
      font-weight: 600;
      color: #222;
    }
    .price del {
      color: #999;
      margin-left: 6px;
      font-weight: normal;
    }
    .btn {
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    .btn-success {
      background-color: #27ae60;
      border: none;
    }
    .btn-success:hover {
      background-color: #219150;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
    }
    .btn-primary:hover {
      background-color: #0056d2;
    }
    .fade-item {
      animation: fadeIn 0.4s ease;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.98); }
      to { opacity: 1; transform: scale(1); }
    }

    @media (max-width: 768px) {
      .card img {
        height: 160px;
      }
    }
  </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<!-- Drawer / Filter Sidebar -->
<div id="filterDrawer" class="filter-drawer">
  <div class="filter-header d-flex justify-content-between align-items-center">
    <h5 class="mb-0">Filters</h5>
    <button class="btn-close" id="btnCloseDrawer"></button>
  </div>
  <div class="filter-body">
    <!-- Brand -->
    <div class="mb-3">
      <h6>Brand</h6>
      <div>
        <input type="checkbox" id="brandApple" name="brand" value="Apple"> <label for="brandApple">Apple</label><br>
        <input type="checkbox" id="brandSamsung" name="brand" value="Samsung"> <label for="brandSamsung">Samsung</label><br>
        <input type="checkbox" id="brandLenovo" name="brand" value="Lenovo"> <label for="brandLenovo">Lenovo</label><br>
        <input type="checkbox" id="brandXiaomi" name="brand" value="Xiaomi"> <label for="brandXiaomi">Xiaomi</label>
      </div>
    </div>
    <!-- Color -->
    <div class="mb-3">
      <h6>Color</h6>
      <div>
        <input type="checkbox" id="colorBlack" name="color" value="Black"> <label for="colorBlack">Black</label><br>
        <input type="checkbox" id="colorSilver" name="color" value="Silver"> <label for="colorSilver">Silver</label><br>
        <input type="checkbox" id="colorGold" name="color" value="Gold"> <label for="colorGold">Gold</label><br>
        <input type="checkbox" id="colorBlue" name="color" value="Blue"> <label for="colorBlue">Blue</label>
      </div>
    </div>
    <!-- RAM -->
    <div class="mb-3">
      <h6>RAM</h6>
      <div>
        <input type="checkbox" id="ram4" name="ram" value="4"> <label for="ram4">4 GB</label><br>
        <input type="checkbox" id="ram6" name="ram" value="6"> <label for="ram6">6 GB</label><br>
        <input type="checkbox" id="ram8" name="ram" value="8"> <label for="ram8">8 GB</label><br>
        <input type="checkbox" id="ram12" name="ram" value="12"> <label for="ram12">12 GB</label>
      </div>
    </div>
    <!-- Size (Display) -->
    <div class="mb-3">
      <h6>Size (inches)</h6>
      <div>
        <input type="checkbox" id="size8" name="size" value="8"> <label for="size8">8″</label><br>
        <input type="checkbox" id="size10" name="size" value="10"> <label for="size10">10″</label><br>
        <input type="checkbox" id="size12" name="size" value="12"> <label for="size12">12″</label>
      </div>
    </div>
  </div>
  <div class="filter-footer">
    <button class="btn btn-primary btn-sm" id="btnApplyFilters">Apply</button>
  </div>
</div>

<!-- Overlay -->
<div id="overlay" class="overlay"></div>

<div class="container my-5">
  <div class="d-flex justify-content-between align-items-center mb-3">
    
    <button class="btn btn-outline-secondary" id="btnOpenDrawer">
      <i class="fa-solid fa-sliders"></i> Filters
    </button>
  </div>

  <div class="d-flex justify-content-end mb-3">
    <select id="sortSelect" class="form-select w-auto">
      <option value="default">Sort By</option>
      <option value="lowToHigh">Price: Low to High</option>
      <option value="highToLow">Price: High to Low</option>
    </select>
  </div>

  <div id="tabletGrid" class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
    <!-- Example cards with data attributes for filtering & sorting -->
    <div class="col" data-price="550" data-rating="4" data-brand="Apple" data-color="Silver" data-ram="8" data-size="10">
      <div class="card h-100 fade-item">
        <i class="fa-regular fa-heart heart"></i>
        <img src="https://images.unsplash.com/photo-1611078489935-0cb964de46c1?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="iPad Air">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title">Apple iPad Air</h5>
          <p class="card-text text-muted">A14 chip, Retina display</p>
          <div class="rating mb-2">★★★★☆</div>
          <div class="price mb-2">$550 <del>$600</del></div>
          <div class="d-flex gap-2 mt-auto">
            <button class="btn btn-success btn-sm flex-fill">Buy Now</button>
            <button class="btn btn-primary btn-sm flex-fill">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
    <div class="col" data-price="450" data-rating="5" data-brand="Samsung" data-color="Black" data-ram="8" data-size="11">
      <div class="card h-100 fade-item">
        <i class="fa-regular fa-heart heart"></i>
        <img src="https://images.unsplash.com/photo-1618413910294-8f6c6aaebc6c?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Galaxy Tab S7">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title">Samsung Galaxy Tab S7</h5>
          <p class="card-text text-muted">Snapdragon, 11″ display</p>
          <div class="rating mb-2">★★★★★</div>
          <div class="price mb-2">$450 <del>$500</del></div>
          <div class="d-flex gap-2 mt-auto">
            <button class="btn btn-success btn-sm flex-fill">Buy Now</button>
            <button class="btn btn-primary btn-sm flex-fill">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
    <div class="col" data-price="130" data-rating="3" data-brand="Lenovo" data-color="Black" data-ram="4" data-size="8">
      <div class="card h-100 fade-item">
        <i class="fa-regular fa-heart heart"></i>
        <img src="https://images.unsplash.com/photo-1577985051167-3e0e3259db1a?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Lenovo Tab M8">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title">Lenovo Tab M8</h5>
          <p class="card-text text-muted">Compact & budget</p>
          <div class="rating mb-2">★★★☆☆</div>
          <div class="price mb-2">$130 <del>$150</del></div>
          <div class="d-flex gap-2 mt-auto">
            <button class="btn btn-success btn-sm flex-fill">Buy Now</button>
            <button class="btn btn-primary btn-sm flex-fill">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
    <!-- Add more cards similarly with correct data-* attributes -->
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Drawer open / close logic
  const drawer = document.getElementById('filterDrawer');
  const overlay = document.getElementById('overlay');
  const btnOpen = document.getElementById('btnOpenDrawer');
  const btnClose = document.getElementById('btnCloseDrawer');

  btnOpen.addEventListener('click', () => {
    drawer.classList.add('open');
    overlay.classList.add('show');
  });
  btnClose.addEventListener('click', () => {
    drawer.classList.remove('open');
    overlay.classList.remove('show');
  });
  overlay.addEventListener('click', () => {
    drawer.classList.remove('open');
    overlay.classList.remove('show');
  });

  // Heart toggle
  document.querySelectorAll('.heart').forEach(icon => {
    icon.addEventListener('click', () => {
      icon.classList.toggle('active');
    });
  });

  // Sorting
  const sortSelect = document.getElementById('sortSelect');
  const grid = document.getElementById('tabletGrid');

  sortSelect.addEventListener('change', () => {
    const cols = Array.from(grid.children);
    let sorted;
    if (sortSelect.value === 'lowToHigh') {
      sorted = cols.sort((a, b) => +a.dataset.price - +b.dataset.price);
    } else if (sortSelect.value === 'highToLow') {
      sorted = cols.sort((a, b) => +b.dataset.price - +a.dataset.price);
    } else {
      sorted = cols;
    }
    // Clear and re-append
    grid.innerHTML = '';
    sorted.forEach(c => {
      c.classList.add('fade-item');
      grid.appendChild(c);
    });
  });

  // Filtering logic
  document.getElementById('btnApplyFilters').addEventListener('click', () => {
    drawer.classList.remove('open');
    overlay.classList.remove('show');

    const chosenBrands = Array.from(document.querySelectorAll('input[name="brand"]:checked')).map(i => i.value);
    const chosenColors = Array.from(document.querySelectorAll('input[name="color"]:checked')).map(i => i.value);
    const chosenRams = Array.from(document.querySelectorAll('input[name="ram"]:checked')).map(i => i.value);
    const chosenSizes = Array.from(document.querySelectorAll('input[name="size"]:checked')).map(i => i.value);

    const cols = Array.from(grid.children);
    cols.forEach(col => {
      let show = true;
      // brand filter
      if (chosenBrands.length && !chosenBrands.includes(col.dataset.brand)) show = false;
      if (chosenColors.length && !chosenColors.includes(col.dataset.color)) show = false;
      if (chosenRams.length && !chosenRams.includes(col.dataset.ram)) show = false;
      if (chosenSizes.length && !chosenSizes.includes(col.dataset.size)) show = false;

      if (show) {
        col.style.display = '';
      } else {
        col.style.display = 'none';
      }
    });
  });
</script>

</body>
</html>
