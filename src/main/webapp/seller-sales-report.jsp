<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Seller"%>
<%@ page import="com.cashify.servlet_cashify_project.dao.SalesDao"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.SalesReport"%>

<%
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SalesDao dao = new SalesDao();
    List<SalesReport> salesList = dao.getSalesBySellerId(seller.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sales Report | Seller Dashboard</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f7f7fa;
}

.sidebar {
	min-height: 100vh;
	background-color: #fff;
	border-right: 1px solid #ddd;
	padding-top: 20px;
}

.sidebar a {
	color: #e22d78;
	display: block;
	padding: 12px 20px;
	margin: 5px 10px;
	border-radius: 8px;
	text-decoration: none;
	transition: all 0.3s;
}

.sidebar a:hover, .sidebar a.active {
	background: linear-gradient(90deg, #ff6a00, #ee0979);
	color: #fff;
	padding-left: 25px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.text-gradient {
	background: linear-gradient(90deg, #ff6a00, #ee0979);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: center;
}

th {
	background-color: #f4f4f4;
}

/* 🔸 Table animation */
@keyframes fadeSlideUp {
	from {
		transform: translateY(40px);
		opacity: 0;
	}
	to {
		transform: translateY(0);
		opacity: 1;
	}
}

.table-animate {
	animation: fadeSlideUp 0.8s ease-out forwards;
}
</style>
</head>
<body>

	<jsp:include page="seller-navbar.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-3 sidebar">
				<a href="seller-home.jsp"><i class="bi bi-house-door"></i>
					Dashboard</a> 
				<a href="seller-added-items.jsp"><i class="bi bi-plus-circle"></i> Sell a Phone</a> 
				<a href="seller-listing.jsp"><i class="bi bi-phone"></i> My Listings</a> 
				<a href="seller-sales-report.jsp" class="active"><i class="bi bi-bar-chart"></i> Sales Report</a> 
				<a href="seller-settings.jsp"><i class="bi bi-gear"></i> Settings</a>
			</div>

			<!-- Main Content -->
			<div class="col-md-9">
				<h2 class="mt-4 text-gradient">Sales Report</h2>

				<form class="row g-3 mb-3" method="get" action="sales"
					class="d-flex align-items-center mb-3">
					<div class="col-auto">
						<label for="sellerId" class="col-form-label">Filter by
							Seller ID:</label>
					</div>
					<div class="col-auto">
						<input type="number" id="sellerId" name="sellerId"
							class="form-control" placeholder="Enter Seller ID">
					</div>

					<div class="col-auto">
						<button type="submit" class="btn btn-primary mb-3"
							style="background-color: #ff6a00; border: none;">Filter</button>
					</div>
				</form>

				<%
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        %>

				<!-- 🔸 Add animation class to the table -->
				<table class="table table-bordered table-striped table-animate">
					<thead>
						<tr>
							<th>ID</th>
							<th>Order ID</th>
							<th>Seller ID</th>
							<th>Product ID</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Total Price</th>
							<th>Status</th>
							<th>Sale Date</th>
						</tr>
					</thead>
					<tbody>
						<%
                    if (salesList != null && !salesList.isEmpty()) {
                        for (SalesReport sale : salesList) {
                %>
						<tr>
							<td><%= sale.getId() %></td>
							<td><%= sale.getOrderId() %></td>
							<td><%= sale.getSellerId() %></td>
							<td><%= sale.getProductId() %></td>
							<td><%= sale.getQuantity() %></td>
							<td><%= sale.getPrice() %></td>
							<td><%= sale.getTotalPrice() %></td>
							<td><%= sale.getStatus() %></td>
							<td><%= sale.getSaleDate().format(formatter) %></td>
						</tr>
						<%
                        }
                    } else {
                %>
						<tr>
							<td colspan="9">No sales found.</td>
						</tr>
						<%
                    }
                %>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
