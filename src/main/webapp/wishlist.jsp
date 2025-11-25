<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.cashify.servlet_cashify_project.dao.ProductDao"%>
<%@page import="com.cashify.servlet_cashify_project.dao.WishlistDao"%>
<%@page import="com.cashify.servlet_cashify_project.dto.Product"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check Login
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
	Product product = new Product();
    WishlistDao wishlistDao = new WishlistDao();
    ProductDao productDao = new ProductDao();   // you must already have ProductDao
    List<Integer> productIds = wishlistDao.getWishlistProducts(userId);

    List<Product> products = new ArrayList<>();
    for (int pid : productIds) {
        Product p = productDao.getProductById(pid);
        if (p != null) products.add(p);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Wishlist</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <style>
        .wishlist-card {
            border-radius: 10px;
            transition: 0.3s;
        }
        .wishlist-card:hover {
            transform: scale(1.02);
            box-shadow: 0px 0px 12px rgba(0,0,0,0.2);
        }
        .remove-btn {
            background-color: red;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
        }
        img.product-img {
            height: 120px;
            object-fit: contain;
        }
    </style>

</head>
<body class="bg-light">

<div class="container mt-4">
    <h2>Your Wishlist ❤️</h2>
    <hr>

    <% if (products.isEmpty()) { %>
        <h4>No items in your wishlist!</h4>
    <% } else { %>

        <div class="row">
            <% for (Product p : products) { %>

            <div class="col-md-3 mt-3">
                <div class="card wishlist-card p-2">
                    <img src="<%= p.getImage() %>" class="product-img" alt="Product Image">

                    <h5 class="mt-2"><%= p.getProductName()%></h5>
                    <h6>₹ <%= p.getPrice() %></h6>

                    <form action="ToggleWishlistController" method="post">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </div>
            </div>

            <% } %>
        </div>

    <% } %>

</div>

</body>
</html>
