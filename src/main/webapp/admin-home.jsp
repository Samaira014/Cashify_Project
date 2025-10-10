<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.cashify.servlet_cashify_project.dto.Admin"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
.main-wrapper {
	margin-top: -69px;
}
/* Fixed navbar height */
.navbar-space {
	height: 65px;
}
/* Sidebar */
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
}

.sidebar a i {
	margin-right: 10px;
}

.sidebar a:hover, .sidebar a.active {
	background-color: #30d5fb;
	border-left: 4px solid #fff;
	font-weight: 600;
}
/* Content */
.content {
	margin-left: 220px;
	padding: 20px;
	margin-top: 65px;
}
/* Stats Cards */
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

.bg-sellers {
	background: linear-gradient(135deg, #ff512f, #dd2476);
}

.bg-delivery {
	background: linear-gradient(135deg, #1fa2ff, #12d8fa);
}
/* Table Styling */
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
/* Admin Info Card */
.admin-card {
	display: flex;
	align-items: center;
	gap: 15px;
	background: white;
	padding: 15px;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.admin-card img {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	object-fit: cover;
}

.admin-card h4 {
	margin: 0;
	font-weight: 600;
}

.admin-card p {
	margin: 0;
	color: #555;
}
/* Responsive */
@media ( max-width : 768px) {
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

	<!-- Include Navbar -->
	<jsp:include page="admin-navbar.jsp"></jsp:include>

	<!-- Main Wrapper -->
	<div class="main-wrapper">

		<!-- Sidebar -->
		<div class="sidebar">
		<h5 class="text-center mb-3">Admin Panel</h5>
			<a href="#" class="active" onclick="showSection('dashboard', this)"><i class="bi bi-house-door-fill"></i> Dashboard</a> 
			<a href="admin-user.jsp" onclick="showSection('users', this)"><i class="bi bi-people-fill"></i> Users</a> 
			<a href="admin-seller.jsp" onclick="showSection('sellers', this)"><i class="bi bi-shop"></i>Sellers</a>
			<a href="admin-delivery.jsp" onclick="showSection('delivery', this)"><i class="bi bi-truck"></i> Delivery Persons</a>

		</div>

		<!-- Content -->
		<div class="content">

			<!-- Admin Info Card -->
			<%
			Admin admin = (Admin) request.getAttribute("admin");
			String adminName = (admin != null && admin.getName() != null) ? admin.getName() : "Admin";
			%>
			<div class="admin-card">
				<img src="./images/avtar.jpg" alt="Admin Photo">
				<div>
					<h4><%=adminName%></h4>
					<p>Super Admin</p>
				</div>
			</div>

			<!-- Stats Cards -->
			<div class="stats">
				<div class="card-stats bg-users">
					<h5>Total Users</h5>
					<h3><%=request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0%></h3>
					<i class="fas fa-users"></i>
				</div>
				<div class="card-stats bg-sellers">
					<h5>Total Sellers</h5>
					<h3><%=request.getAttribute("totalSellers") != null ? request.getAttribute("totalSellers") : 0%></h3>
					<i class="fas fa-store"></i>
				</div>
				<div class="card-stats bg-delivery">
					<h5>Delivery Persons</h5>
					<h3><%=request.getAttribute("totalDelivery") != null ? request.getAttribute("totalDelivery") : 0%></h3>
					<i class="fas fa-truck"></i>
				</div>
			</div>

			<!-- Users Section -->
			<div id="users" class="table-container" style="display: none;">
				<h4>Registered Users</h4>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Details</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
						if (users != null && !users.isEmpty()) {
							for (Map<String, String> u : users) {
						%>
						<tr>
							<td><%=u.get("id")%></td>
							<td><%=u.get("name")%></td>
							<td><%=u.get("email")%></td>
							<td><%=u.get("phone")%></td>
							<td><button class="btn btn-primary btn-sm"
									onclick="showUserDetails('<%=u.get("id")%>')">View</button></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="5" class="text-center">No users found</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

				<!-- User Details -->
				<div id="userDetails" style="display: none; margin-top: 20px;">
					<h4>User Orders</h4>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Order ID</th>
								<th>Product</th>
								<th>Status</th>
								<th>Returned</th>
							</tr>
						</thead>
						<tbody id="userOrdersBody"></tbody>
					</table>
					<button class="btn btn-secondary" onclick="closeUserDetails()">Close</button>
				</div>
			</div>

			<!-- Sellers Section -->
			<div id="sellers" class="table-container" style="display: none;">
				<h4>Sellers</h4>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Shop Name</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Map<String, String>> sellers = (List<Map<String, String>>) request.getAttribute("sellers");
						if (sellers != null && !sellers.isEmpty()) {
							for (Map<String, String> s : sellers) {
						%>
						<tr>
							<td><%=s.get("id")%></td>
							<td><%=s.get("name")%></td>
							<td><%=s.get("email")%></td>
							<td><%=s.get("phone")%></td>
							<td><%=s.get("shop_name")%></td>
							<td><span
								class="badge <%=s.get("status").equals("Active") ? "bg-success" : "bg-danger"%>"><%=s.get("status")%></span></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="6" class="text-center">No sellers found</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

			<!-- Delivery Section -->
			<div id="delivery" class="table-container" style="display: none;">
				<h4>Delivery Persons</h4>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Map<String, String>> delivery = (List<Map<String, String>>) request.getAttribute("deliverypersons");
						if (delivery != null && !delivery.isEmpty()) {
							for (Map<String, String> d : delivery) {
						%>
						<tr>
							<td><%=d.get("id")%></td>
							<td><%=d.get("name")%></td>
							<td><%=d.get("email")%></td>
							<td><%=d.get("phone")%></td>
							<td><span
								class="badge <%=d.get("status").equals("Available") ? "bg-success" : "bg-warning"%>"><%=d.get("status")%></span></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="5" class="text-center">No delivery persons
								found</td>
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
		<script>
		function showSection(id, element){
		    document.querySelectorAll('.table-container').forEach(t => t.style.display='none');
		    document.getElementById(id).style.display='block';
		    document.querySelectorAll('.sidebar a').forEach(a => a.classList.remove('active'));
		    element.classList.add('active');
		    if(id !== 'users') document.getElementById('userDetails').style.display='none';
		}


function showUserDetails(userId){
    fetch('UserOrdersController?userId='+userId)
    .then(res=>res.json())
    .then(data=>{
        const tbody=document.getElementById('userOrdersBody');
        tbody.innerHTML='';
        data.forEach(order=>{
            const tr=document.createElement('tr');
            tr.innerHTML=`<td>${order.id}</td><td>${order.product}</td><td>${order.status}</td><td>${order.returned}</td>`;
            tbody.appendChild(tr);
        });
        document.getElementById('userDetails').style.display='block';
    });
}

function closeUserDetails(){ document.getElementById('userDetails').style.display='none'; }
</script>
</body>
</html>
