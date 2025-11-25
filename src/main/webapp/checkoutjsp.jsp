<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.*" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.*" %>

<%
    // ✅ Check login
    Object user = session.getAttribute("user");
    if (user == null) {
        session.setAttribute("message", "Please login to continue checkout.");
        response.sendRedirect("login.jsp");
        return;
    }

    CartItemDao cartItemDao = new CartItemDao();
    ProductDao productDao = new ProductDao();

    // ✅ Get user’s cart
    // Assuming user object has getId() -> userId
    int userId = (int) user.getClass().getMethod("getId").invoke(user);
    Cart cart = cartItemDao.getCartDetails(userId);
    List<CartItems> cartItems = cartItemDao.getCartItemsByCartId(cart.getId());

    double totalAmount = 0.0;
    int totalItems = 0;
    Map<CartItems, Product> cartProductMap = new LinkedHashMap<>();

    for (CartItems item : cartItems) {
        Product product = productDao.getProductById(item.getProductid());
        if (product != null) {
            totalAmount += item.getPrice();
            totalItems += item.getQuantity();
            cartProductMap.put(item, product);
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout | Cashify</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .checkout-container {
            max-width: 1000px;
            margin: 30px auto;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
        }
        .btn-place-order {
            background-color: #fb641b;
            color: white;
            font-weight: bold;
        }
        .btn-place-order:hover {
            background-color: #e85a12;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="container checkout-container">
    <div class="row g-3">

        <!-- Left: Product Summary -->
        <div class="col-lg-8">
            <div class="card p-3">
                <h5 class="fw-bold mb-3">Order Summary</h5>
                <% if (cartProductMap.isEmpty()) { %>
                    <p class="text-muted text-center my-4">Your cart is empty. <a href="products">Shop Now</a></p>
                <% } else { %>
                    <% for (Map.Entry<CartItems, Product> entry : cartProductMap.entrySet()) { 
                        CartItems item = entry.getKey();
                        Product product = entry.getValue();
                    %>
                        <div class="d-flex align-items-center border-bottom pb-2 mb-2">
                            <img src="<%=request.getContextPath()%>/product-image?id=<%=product.getId()%>" class="product-img me-3" alt="<%=product.getProductName()%>">
                            <div class="flex-grow-1">
                                <h6 class="mb-1"><%=product.getProductName()%></h6>
                                <small class="text-muted"><%=product.getBrand()%> • <%=product.getColor()%> • <%=product.getRam()%>GB RAM</small>
                                <div class="mt-1">Qty: <%=item.getQuantity()%></div>
                            </div>
                            <div class="fw-bold text-success">₹<%=Math.round(item.getPrice())%></div>
                        </div>
                    <% } %>
                <% } %>
            </div>

            <!-- Shipping Address -->
            <div class="card p-3 mt-3">
                <h5 class="fw-bold mb-3">Shipping Address</h5>
                <form action="placeOrder" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullname" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phone" class="form-control" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Address</label>
                            <textarea name="address" class="form-control" rows="3" required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">City</label>
                            <input type="text" name="city" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Pincode</label>
                            <input type="text" name="pincode" class="form-control" required>
                        </div>
                    </div>

                    <input type="hidden" name="cartId" value="<%=cart.getId()%>">

                    <div class="text-end mt-3">
                        <button type="submit" class="btn btn-place-order px-5 py-2">
                            Place Order
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Right: Price Details -->
        <div class="col-lg-4">
            <div class="card p-3">
                <h6 class="fw-bold mb-3 text-muted">PRICE DETAILS</h6>
                <div class="d-flex justify-content-between mb-2">
                    <span>Price (<%=totalItems%> items)</span>
                    <span>₹<%=Math.round(totalAmount)%></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Delivery Charges</span>
                    <span class="text-success">FREE</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold">
                    <span>Total Amount</span>
                    <span>₹<%=Math.round(totalAmount)%></span>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
