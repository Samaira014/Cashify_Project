<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller" %>
<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Seller Dashboard | Cashify</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        background: #f8f9fa;
        font-family: 'Poppins', sans-serif;
    }

    /* 🌟 Header */
    .header {
        background: linear-gradient(135deg, #1d2671, #c33764);
        color: #fff;
        padding: 20px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        border-radius: 0 0 20px 20px;
    }
    .header h2 {
        margin: 0;
        font-weight: 700;
        font-size: 1.8rem;
    }
    .logout-btn {
        background: #fff;
        color: #c33764;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        transition: 0.3s;
    }
    .logout-btn:hover {
        background: #c33764;
        color: #fff;
    }

    /* 🌈 Stats Section */
    .stats-section {
        margin: 40px auto;
        max-width: 1000px;
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        justify-content: center;
    }
    .stat-card {
        flex: 1 1 250px;
        border-radius: 18px;
        color: #fff;
        text-align: center;
        padding: 35px 20px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        transition: all 0.4s ease;
    }
    .stat-card.assigned { background: linear-gradient(135deg, #667eea, #764ba2); }
    .stat-card.completed { background: linear-gradient(135deg, #43cea2, #185a9d); }
    .stat-card.pending { background: linear-gradient(135deg, #f7971e, #ffd200); }

    .stat-card .icon { font-size: 2.5rem; margin-bottom: 10px; }
    .stat-card h5 { font-weight: 600; margin-bottom: 10px; }
    .stat-card h2 { font-weight: 800; font-size: 2.5rem; }

    .stat-card:hover { transform: translateY(-10px) scale(1.05); }

    /* 🌟 Table Section */
    .card-table {
        margin: 20px auto;
        max-width: 1200px;
        padding: 30px;
        border-radius: 18px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        background: #fff;
    }
    .badge-delivered { background-color: #28a745; color: #fff; }
    .badge-pending { background-color: #ffc107; color: #212529; }
    .badge-delayed { background-color: #dc3545; color: #fff; }

    /* 🧭 Action Buttons */
    .actions {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 30px;
    }
    .actions a {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: #fff;
        font-weight: 600;
        padding: 12px 25px;
        border-radius: 10px;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 6px 12px rgba(0,0,0,0.1);
    }
    .actions a:hover {
        background: linear-gradient(135deg, #764ba2, #667eea);
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }
</style>
</head>

<body>
    <!-- 🌟 Header -->
    <div class="header">
        <h2>Welcome, <%= seller.getName() %> 👋</h2>
        <form action="logout" method="post" style="margin: 0;">
            <button type="submit" class="logout-btn"><i class="bi bi-box-arrow-right"></i> Logout</button>
        </form>
    </div>

    <!-- 🌈 Stats Cards -->
    <div class="stats-section">
        <div class="stat-card assigned">
            <div class="icon"><i class="bi bi-box"></i></div>
            <h5>Assigned Deliveries</h5>
            <h2><%= request.getAttribute("assignedCount") != null ? request.getAttribute("assignedCount") : 0 %></h2>
        </div>
        <div class="stat-card completed">
            <div class="icon"><i class="bi bi-check-circle"></i></div>
            <h5>Completed</h5>
            <h2><%= request.getAttribute("completedCount") != null ? request.getAttribute("completedCount") : 0 %></h2>
        </div>
        <div class="stat-card pending">
            <div class="icon"><i class="bi bi-hourglass-split"></i></div>
            <h5>Pending</h5>
            <h2><%= request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : 0 %></h2>
        </div>
    </div>

    <!-- 📦 Recent Assigned Deliveries Table -->
    <div class="card card-table">
        <h5 class="mb-3">📦 Recent Assigned Deliveries</h5>
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Products</th>
                        <th>Status</th>
                        <th>Delivery Date</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List deliveries = (List) request.getAttribute("assignedDeliveries");
                    if (deliveries != null && !deliveries.isEmpty()) {
                        for (Object obj : deliveries) {
                            Map d = (Map) obj;
                %>
                    <tr>
                        <td><%= d.get("order_id") %></td>
                        <td><%= d.get("customer_name") %></td>
                        <td><%= d.get("customer_phone") %></td>
                        <td><%= d.get("address") %></td>
                        <td><%= d.get("products") %></td>
                        <td>
                            <span class="badge 
                                <%= "Delivered".equals(d.get("status")) ? "badge-delivered" 
                                    : "Pending".equals(d.get("status")) ? "badge-pending" 
                                    : "badge-delayed" %>">
                                <%= d.get("status") %>
                            </span>
                        </td>
                        <td><%= d.get("delivery_date") %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr><td colspan="7" class="text-center">No assigned deliveries yet 🚚</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
