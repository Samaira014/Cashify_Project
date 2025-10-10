<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.User"%>
<%@ page import="com.cashify.servlet_cashify_project.dto.Order"%>
<%@ page import="com.cashify.servlet_cashify_project.dao.UserDao"%>
<%@ page import="com.cashify.servlet_cashify_project.dao.OrderDao"%>
<%
// Fetch users and counts
UserDao userDao = new UserDao();
OrderDao orderDao = new OrderDao();

List<User> users = userDao.getAllUsers();
int totalUsers = userDao.getTotalUsers();
List<Order> allOrders = orderDao.getAllOrders();
List<Order> returnedOrders = orderDao.getReturnedOrders();
List<Order> pendingOrders = orderDao.getOrdersByPaymentStatus("Pending");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Users</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
.main-wrapper {
	margin-top: -69px;
}

.sidebar {
	width: 220px;
	background: linear-gradient(180deg, #2f71a1, #6ecfde);
	color: white;
	position: fixed;
	top: 65px;
	bottom: 0;
	padding-top: 20px;
	overflow-y: auto;
	transition: all 0.3s;
	z-index: 100;
}

.sidebar a {
	display: flex;
	align-items: center;
	color: white;
	padding: 12px 20px;
	text-decoration: none;
	border-left: 4px solid transparent;
	transition: all 0.3s;
	gap: 6px;
}

.sidebar a:hover, .sidebar a.active {
	background-color: #30d5fb;
	border-left: 4px solid #fff;
	font-weight: 600;
}

.content {
	margin-left: 220px;
	padding: 20px;
	margin-top: 65px;
}

.stats {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	margin-bottom: 20px;
}

.card-stats {
	flex: 1;
	min-width: 150px;
	border-radius: 12px;
	color: white;
	padding: 20px;
	position: relative;
	overflow: hidden;
	cursor: pointer;
	transition: transform 0.3s;
	text-align: center;
}

.card-stats:hover {
	transform: translateY(-5px);
}

.card-stats i {
	font-size: 2rem;
	opacity: 0.3;
	position: absolute;
	top: 10px;
	right: 15px;
}

.bg-users {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.bg-purchased {
	background: linear-gradient(135deg, #00b09b, #96c93d);
}

.bg-returned {
	background: linear-gradient(135deg, #ff512f, #dd2476);
}

.bg-pending {
	background: linear-gradient(135deg, #1fa2ff, #12d8fa);
}

.table-container {
	background: white;
	border-radius: 12px;
	padding: 15px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	transition: all 0.5s ease;
}

.table thead {
	background: linear-gradient(90deg, #6a11cb, #2575fc);
	color: white;
}

.table tbody tr:hover {
	background: rgba(37, 117, 252, 0.1);
	transition: 0.3s;
}

.badge:hover {
	transform: scale(1.1);
	transition: transform 0.3s;
}

@media ( max-width :768px) {
	.content {
		margin-left: 0;
		margin-top: 65px;
	}
	.sidebar {
		position: relative;
		width: 100%;
		top: 0;
		height: auto;
		padding-top: 0;
	}
	.stats {
		flex-direction: column;
	}
}
</style>
</head>
<body>

	<jsp:include page="admin-navbar.jsp" />

	<div class="main-wrapper">
		<!-- Sidebar -->
		<div class="sidebar">
			<h5 class="text-center mb-3">Admin Panel</h5>
			<a href="admin-home.jsp"><i class="bi bi-house-door-fill"></i>
				Dashboard</a> <a href="admin-user.jsp" class="active"><i
				class="bi bi-people-fill"></i> Users</a> <a href="admin-seller.jsp"><i
				class="bi bi-shop"></i> Sellers</a> <a href="admin-delivery.jsp"><i
				class="bi bi-truck"></i> Delivery Persons</a>
		</div>

		<!-- Content -->
		<div class="content">

			<!-- Dashboard Cards -->
			<div class="stats">
				<div class="card-stats bg-users" onclick="showSection('usersTable')">
					<h5>Total Users</h5>
					<h3><%=totalUsers%></h3>
					<i class="fas fa-users"></i>
				</div>

				<div class="card-stats bg-purchased"
					onclick="showSection('purchasedTable')">
					<h5>Purchased Products</h5>
					<h3><%=allOrders.size()%></h3>
					<i class="fas fa-cart-shopping"></i>
				</div>

				<div class="card-stats bg-returned"
					onclick="showSection('returnedTable')">
					<h5>Returned Items</h5>
					<h3><%=returnedOrders.size()%></h3>
					<i class="fas fa-undo"></i>
				</div>

				<div class="card-stats bg-pending"
					onclick="showSection('pendingTable')">
					<h5>Pending Delivery</h5>
					<h3><%=pendingOrders.size()%></h3>
					<i class="fas fa-truck"></i>
				</div>

			</div>

			<!-- Users Table -->
			<div class=" table-container" id="usersTable">
				<h5>All Registered Users</h5>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Orders</th>
						</tr>
					</thead>
					<tbody>
						<%
						int collapseIndex = 1;
						for (User u : users) {
							List<Order> userOrders = orderDao.getOrdersByUserId(u.getId());
						%>
						<tr>
							<td><%=u.getId()%></td>
							<td><%=u.getName()%></td>
							<td><%=u.getEmail()%></td>
							<td><%=u.getPhone()%></td>
							<td>
								<button class="btn btn-sm btn-primary" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#userOrders<%=collapseIndex%>">
									View Orders (<%=userOrders.size()%>)
								</button>
							</td>
						</tr>
						<tr class="collapse" id="userOrders<%=collapseIndex%>">
							<td colspan="5">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th><a href="admin-user.jsp?sortField=id&sortDir=asc">Order
													ID</a></th>
											<th><a
												href="admin-user.jsp?sortField=userid&sortDir=asc">User
													ID</a></th>
											<th><a
												href="admin-user.jsp?sortField=product_id&sortDir=asc">Product
													ID</a></th>
											<th><a
												href="admin-user.jsp?sortField=quantity&sortDir=asc">Quantity</a></th>
											<th><a
												href="admin-user.jsp?sortField=total_price&sortDir=asc">Total
													Price</a></th>
											<th><a
												href="admin-user.jsp?sortField=status&sortDir=asc">Status</a></th>
											<th>Delivery Note</th>
											<th><a
												href="admin-user.jsp?sortField=delivery_date&sortDir=asc">Delivery
													Date</a></th>
										</tr>
									</thead>
									<tbody>
										<%
										for (Order o : allOrders) {
										%>
										<tr>
											<td><%=o.getId()%></td>
											<td><%=o.getUserid()%></td>
											<td><%=o.getProduct_id()%></td>
											<td><%=o.getQuantity()%></td>
											<td><%=o.getTotal_price()%></td>
											<td><%=o.getPayment_status()%></td>
											<td><%=o.getDelivery_note() != null ? o.getDelivery_note() : "No"%></td>
											<td><%=o.getDelivery_date() != null ? o.getDelivery_date() : "-"%></td>
										</tr>
										<%
										}
										%>
									</tbody>
								</table>
							</td>
						</tr>
						<%
						collapseIndex++;
						}
						%>
					</tbody>
				</table>
			</div>

			<!-- Purchased Products Table -->
			<div class="collapse table-container" id="purchasedTable">
				<h5>All Purchased Products</h5>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>User ID</th>
							<th>Product ID</th>
							<th>Quantity</th>
							<th>Total Price</th>
							<th>Status</th>
							<th>Delivery Note</th>
							<th>Delivery Date</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Order o : allOrders) {
						%>
						<tr>
							<td><%=o.getId()%></td>
							<td><%=o.getUserid()%></td>
							<td><%=o.getProduct_id()%></td>
							<td><%=o.getQuantity()%></td>
							<td><%=o.getTotal_price()%></td>
							<td><%=o.getPayment_status()%></td>
							<td><%=o.getDelivery_note() != null ? o.getDelivery_note() : "No"%></td>
							<td><%=o.getDelivery_date() != null ? o.getDelivery_date() : "-"%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

			<!-- Returned Orders Table -->
			<div class="collapse table-container" id="returnedTable">
				<h5>Returned Items</h5>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>User ID</th>
							<th>Product ID</th>
							<th>Quantity</th>
							<th>Total Price</th>
							<th>Status</th>
							<th>Delivery Note</th>
							<th>Delivery Date</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Order o : returnedOrders) {
						%>
						<tr>
							<td><%=o.getId()%></td>
							<td><%=o.getUserid()%></td>
							<td><%=o.getProduct_id()%></td>
							<td><%=o.getQuantity()%></td>
							<td><%=o.getTotal_price()%></td>
							<td><%=o.getPayment_status()%></td>
							<td><%=o.getDelivery_note() != null ? o.getDelivery_note() : "Yes"%></td>
							<td><%=o.getDelivery_date() != null ? o.getDelivery_date() : "-"%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

			<!-- Pending Orders Table -->
			<div class="collapse table-container" id="pendingTable">
				<h5>Pending Delivery Orders</h5>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>User ID</th>
							<th>Product ID</th>
							<th>Quantity</th>
							<th>Total Price</th>
							<th>Status</th>
							<th>Delivery Note</th>
							<th>Delivery Date</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Order o : pendingOrders) {
						%>
						<tr>
							<td><%=o.getId()%></td>
							<td><%=o.getUserid()%></td>
							<td><%=o.getProduct_id()%></td>
							<td><%=o.getQuantity()%></td>
							<td><%=o.getTotal_price()%></td>
							<td><%=o.getPayment_status()%></td>
							<td><%=o.getDelivery_note() != null ? o.getDelivery_note() : "No"%></td>
							<td><%=o.getDelivery_date() != null ? o.getDelivery_date() : "-"%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

		</div>
	</div>
	<script>
function showSection(sectionId) {
    // List of all sections
    const sections = ['usersTable', 'purchasedTable', 'returnedTable', 'pendingTable'];
    
    sections.forEach(id => {
        const el = document.getElementById(id);
        if(el) {
            el.style.display = (id === sectionId) ? 'block' : 'none';
        }
    });
}
</script>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
