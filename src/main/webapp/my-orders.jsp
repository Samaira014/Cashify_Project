<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.OrderDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dao.ProductDao" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Order" %>
<%@ page import="com.cashify.servlet_cashify_project.dto.Product" %>
 <%
    // ✅ Check if user is logged in
    String userSession = (String) session.getAttribute("userSession");
    Integer userId = (Integer) session.getAttribute("userid");

    if (userSession == null || userId == null) {
        // Not logged in — redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }
    
    OrderDao orderDao = new OrderDao();
    ProductDao productDao = new ProductDao();
    List<Order> orders = orderDao.getOrdersByUserId(userId);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders | Cashify</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- ✅ Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .order-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 20px;
            transition: all 0.2s ease;
        }
        .order-card:hover {
            transform: translateY(-3px);
        }
        .product-img {
            width: 90px;
            height: 90px;
            border-radius: 10px;
            object-fit: cover;
        }
        .status-badge {
            font-size: 0.85rem;
            padding: 6px 10px;
        }
        .order-header {
            color: #007bff;
            font-weight: 600;
        }
        .no-orders {
            background-color: white;
            border-radius: 15px;
            padding: 50px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>


<div class="container py-5">
    <h2 class="text-center mb-4 fw-bold text-primary">My Orders</h2>

    <% 
    
    if (orders == null || orders.isEmpty()) { %>
        <div class="no-orders text-center">
            <h5>You haven't placed any orders yet.</h5>
            <a href="home.jsp" class="btn btn-primary mt-3">Continue Shopping</a>
        </div>
    <% } else { 
        for (Order order : orders) {
            Product product = productDao.getProductById(order.getProduct_id());
    %>

    <div class="order-card">
        <div class="row align-items-center">
            <div class="col-md-2 text-center">
                <img src="<%= product != null && product.getImage() != null ? product.getImage() : "images/no-image.png" %>"
                     alt="Product Image" class="product-img">
            </div>

            <div class="col-md-4">
                <h5><%= product != null ? product.getProductName() : "Unknown Product" %></h5>
                <p class="text-muted mb-1">Quantity: <%= order.getQuantity() %></p>
                <p class="text-muted mb-0">Ordered on: 
                    <%= order.getCreated_at() != null ? order.getCreated_at().toString().substring(0, 10) : "N/A" %>
                </p>
            </div>

            <div class="col-md-2">
                <h6 class="text-success mb-0">₹<%= order.getTotal_price() %></h6>
            </div>

            <div class="col-md-2">
                <span class="badge bg-<%= 
                    order.getPayment_status().equalsIgnoreCase("Delivered") ? "success" :
                    order.getPayment_status().equalsIgnoreCase("Pending") ? "warning" :
                    order.getPayment_status().equalsIgnoreCase("Cancelled") ? "danger" : "secondary" 
                %> status-badge">
                    <%= order.getPayment_status() %>
                </span>
            </div>

            <div class="col-md-2 text-end">
                <a href="orderDetails.jsp?id=<%= order.getId() %>" class="btn btn-outline-primary btn-sm">View</a>
                <% if (!"Delivered".equalsIgnoreCase(order.getPayment_status())) { %>
                    <a href="cancelOrder?id=<%= order.getId() %>" class="btn btn-outline-danger btn-sm">Cancel</a>
                <% } %>
            </div>
        </div>

        <% if (order.getDelivery_note() != null && !order.getDelivery_note().isEmpty()) { %>
            <div class="mt-3">
                <small class="text-muted"><b>Delivery Note:</b> <%= order.getDelivery_note() %></small>
            </div>
        <% } %>
    </div>

    <% } } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
