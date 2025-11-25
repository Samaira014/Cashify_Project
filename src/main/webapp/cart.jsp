<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.CartItems" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.ProductDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.CartItemDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Cart" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.User" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
    CartItemDao cartDao = new CartItemDao();
    ProductDao productDao = new ProductDao();

    Cart cart = cartDao.getCartDetails(user.getId());
    double totalPrice = 0;
    List<CartItems> cartItems = null;
    if (cart != null) {
        cartItems = cartDao.getCartItemsByCartId(cart.getId());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cart | Cashify</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .cart-container {
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
        }
        .cart-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .product-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }
        .quantity-input {
            width: 60px;
            text-align: center;
        }
        .summary-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        .btn-checkout {
            width: 100%;
            background-color: #2874f0;
            color: white;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container cart-container">
    <h3 class="mb-4">My Cart</h3>

    <%
        if (cartItems == null || cartItems.isEmpty()) {
    %>
        <div class="text-center p-5">
            <h5>Your cart is empty 🛒</h5>
            <a href="shop.jsp" class="btn btn-primary mt-3">Continue Shopping</a>
        </div>
    <%
        } else {
            for (CartItems item : cartItems) {
                Product p = productDao.getProductById(item.getProductid());
                if (p != null) {
                    double total = item.getQuantity() * item.getPrice();
                    totalPrice += total;
    %>
        <div class="cart-item row align-items-center">
            <div class="col-md-2">
                <img src="<%=p.getImage()%>" class="product-img" alt="Product Image">
            </div>
            <div class="col-md-4">
                <h5><%=p.getProductName()%></h5>
                <p class="text-muted"><%=p.getCategory()%></p>
                <p>₹<%=item.getPrice()%> x <%=item.getQuantity()%> = <strong>₹<%=total%></strong></p>
            </div>
            <div class="col-md-3">
                <form action="updateCartItem" method="post" class="d-flex align-items-center">
                    <input type="hidden" name="itemId" value="<%=item.getItemsid()%>">
                    <input type="number" name="quantity" value="<%=item.getQuantity()%>" class="form-control quantity-input me-2" min="1">
                    <button type="submit" class="btn btn-sm btn-outline-primary">Update</button>
                </form>
            </div>
            <div class="col-md-3 text-end">
                <form action="addToCart" method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="<%=p.getId()%>">
                    <button type="submit" class="btn btn-outline-danger btn-sm">Remove</button>
                </form>
            </div>
        </div>
    <%
                }
            }
        }
    %>

    <% if (cartItems != null && !cartItems.isEmpty()) { %>
    <div class="summary-box mt-4">
        <h5>Price Summary</h5>
        <hr>
        <p><strong>Total Price:</strong> ₹<%=totalPrice%></p>
        <a href="checkout.jsp" class="btn btn-checkout mt-3">Proceed to Checkout</a>
    </div>
    <% } %>
</div>

</body>
</html>
