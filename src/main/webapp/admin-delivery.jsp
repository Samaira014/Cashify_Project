
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page
	import="com.cashify.servlet_cashify_project.dao.DeliveryPersonDao"%>
<%@page import="com.cashify.servlet_cashify_project.dto.DeliveryPerson"%>

<%
DeliveryPersonDao dao = new DeliveryPersonDao();
List<DeliveryPerson> deliveryPersons = dao.getAllDeliveryPersons();

// Counts
int totalDelivery = deliveryPersons.size();
int availableCount = 0;
int notAvailableCount = 0;
int totalDelivered = 0;

for (DeliveryPerson d : deliveryPersons) {
	if (d.isAvailable())
		availableCount++;
	else
		notAvailableCount++;
	totalDelivered += d.getDeliveredCount();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Delivery Persons</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
body {
	font-family: Arial, sans-serif;
}

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
}

.sidebar a {
	display: flex;
	align-items: center;
	color: white;
	padding: 12px 20px;
	text-decoration: none;
	border-left: 4px solid transparent;
	gap: 6px;
}

.sidebar a.active, .sidebar a:hover {
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
	text-align: center;
	cursor: pointer;
	transition: 0.3s;
}

.card-stats:hover {
	transform: translateY(-5px);
}

.bg-total {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.bg-available {
	background: linear-gradient(135deg, #00b09b, #96c93d);
}

.bg-notavailable {
	background: linear-gradient(135deg, #ff512f, #dd2476);
}

.bg-delivered {
	background: linear-gradient(135deg, #1fa2ff, #12d8fa);
}

.section {
	display: none;
	margin-top: 15px;
}

.table-container {
	background: white;
	border-radius: 12px;
	padding: 15px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>

	<jsp:include page="admin-navbar.jsp"></jsp:include>

	<div class="main-wrapper">
		<!-- Sidebar -->
		<div class="sidebar">
			<h5 class="text-center mb-3">Admin Panel</h5>
			<a href="admin-home.jsp"  onclick="showSection('dashboard', this)"><i class="bi bi-house-door-fill"></i> Dashboard</a> 
			<a href="admin-user.jsp"  onclick="showSection('users', this)"><i class="bi bi-people-fill"></i> Users</a> 
			<a href="admin-seller.jsp"  onclick="showSection('sellers', this)"><i class="bi bi-shop"></i>Sellers</a>
			<a href="admin-delivery.jsp" class="active" onclick="showSection('delivery', this)"><i class="bi bi-truck"></i> Delivery Persons</a>
		</div>

		<!-- Content -->
		<div class="content">
			<!-- Cards -->
			<div class="stats">
				<div class="card-stats bg-total" onclick="showSection('allDiv')">
					<h5><i class="fas fa-users"></i> Total Delivery Persons</h5>
					<h3><%=totalDelivery%></h3>
				</div>
				<div class="card-stats bg-available"
					onclick="showSection('availableDiv')">
					<h5><i class="fas fa-check-circle"></i>Available</h5>
					<h3><%=availableCount%></h3>
				</div>
				<div class="card-stats bg-notavailable"
					onclick="showSection('notAvailableDiv')">
					<h5><i class="fas fa-times-circle"></i>Not Available</h5>
					<h3><%=notAvailableCount%></h3>
				</div>
				<div class="card-stats bg-delivered"
					onclick="showSection('deliveredDiv')">
					<h5><i class="fas fa-box"></i>Total Delivered</h5>
					<h3><%=totalDelivered%></h3>
				</div>
			</div>

			<!-- All Delivery Persons -->
			<div id="allDiv" class="section" style="display: block;">
				<div class="table-container">
					<h5>All Delivery Persons</h5>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Status</th>
								<th>Delivered</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (DeliveryPerson d : deliveryPersons) {
							%>
							<tr>
								<td><%=d.getId()%></td>
								<td><%=d.getName()%></td>
								<td><%=d.getEmail()%></td>
								<td><%=d.getPhone()%></td>
								<td><%=d.isAvailable() ? "Available" : "Not Available"%></td>
								<td><%=d.getDeliveredCount()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Available Delivery Persons -->
			<div id="availableDiv" class="section">
				<div class="table-container">
					<h5>Available Delivery Persons</h5>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Delivered</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (DeliveryPerson d : deliveryPersons) {
								if (d.isAvailable()) {
							%>
							<tr>
								<td><%=d.getId()%></td>
								<td><%=d.getName()%></td>
								<td><%=d.getEmail()%></td>
								<td><%=d.getPhone()%></td>
								<td><%=d.getDeliveredCount()%></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Not Available Delivery Persons -->
			<div id="notAvailableDiv" class="section">
				<div class="table-container">
					<h5>Not Available Delivery Persons</h5>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Delivered</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (DeliveryPerson d : deliveryPersons) {
								if (!d.isAvailable()) {
							%>
							<tr>
								<td><%=d.getId()%></td>
								<td><%=d.getName()%></td>
								<td><%=d.getEmail()%></td>
								<td><%=d.getPhone()%></td>
								<td><%=d.getDeliveredCount()%></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Total Delivered -->
			<div id="deliveredDiv" class="section">
				<div class="table-container">
					<h5>Delivered Products by Each Delivery Person</h5>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Delivered</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (DeliveryPerson d : deliveryPersons) {
							%>
							<tr>
								<td><%=d.getId()%></td>
								<td><%=d.getName()%></td>
								<td><%=d.getEmail()%></td>
								<td><%=d.getPhone()%></td>
								<td><%=d.getDeliveredCount()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>

	<script>
function showSection(id){
    document.querySelectorAll('.section').forEach(s=>s.style.display='none');
    document.getElementById(id).style.display='block';
}
</script>

</body>
</html>
