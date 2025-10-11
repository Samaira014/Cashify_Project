<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.cashify.servlet_cashify_project.dto.DeliveryPerson, java.util.List, java.util.Map"%>

<%
DeliveryPerson delivery = (DeliveryPerson) session.getAttribute("deliveryPerson");
if (delivery == null) {
    response.sendRedirect("delivery-login.jsp");
    return;
}
int assignedCount = request.getAttribute("assignedCount") != null ? (int)request.getAttribute("assignedCount") : 0;
int completedCount = request.getAttribute("completedCount") != null ? (int)request.getAttribute("completedCount") : 0;
int pendingCount = request.getAttribute("pendingCount") != null ? (int)request.getAttribute("pendingCount") : 0;
List<Map<String, Object>> deliveries = (List<Map<String, Object>>) request.getAttribute("allDeliveries");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Delivery History | Cashify</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
/* Copy styles from delivery-home.jsp for sidebar, main-content, stats, table */
.sidebar {
	position: fixed;
	top: 63px;
	left: 0;
	width: 220px;
	height: calc(100vh - 63px);
	background: linear-gradient(135deg, #1d2671, #c33764);
	color: #fff;
	padding-top: 20px;
	display: flex;
	flex-direction: column;
}

.sidebar a {
	color: #fff;
	text-decoration: none;
	padding: 12px 20px;
	display: flex;
	align-items: center;
	gap: 10px;
	border-radius: 8px;
	margin: 4px 10px;
	transition: 0.3s;
}

.sidebar a:hover, .sidebar a.active {
	background: rgba(255, 255, 255, 0.15);
}

.main-content {
	margin-left: 240px;
	padding: 30px;
}

.delivery-profile-row {
	display: flex;
	align-items: center;
	gap: 15px;
	background: #fff;
	border-radius: 12px;
	padding: 10px 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.delivery-profile-row:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.profile-img img {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	object-fit: cover;
	border: 2px solid #1d2671;
}

.profile-info h4 {
	margin: 0;
	font-size: 1.2rem;
	font-weight: 600;
	color: #1d2671;
}

.profile-info p {
	margin: 2px 0 0;
	font-size: 0.85rem;
	color: #555;
}

.stats-section {
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
	margin-bottom: 25px;
}

.stat-card {
	flex: 1 1 150px;
	border-radius: 14px;
	color: #fff;
	text-align: center;
	padding: 15px 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s
		ease;
	cursor: pointer;
}

.stat-card:hover {
	transform: translateY(-7px);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
}

.stat-card .icon {
	font-size: 1.8rem;
	margin-bottom: 8px;
}

.stat-card h5 {
	font-size: 0.9rem;
	margin: 0 0 5px;
}

.stat-card h2 {
	font-size: 1.4rem;
	font-weight: 700;
	margin: 0;
}

.stat-card.assigned {
	background: linear-gradient(135deg, #667eea, #764ba2);
}

.stat-card.completed {
	background: linear-gradient(135deg, #43cea2, #185a9d);
}

.stat-card.pending {
	background: linear-gradient(135deg, #f7971e, #ffd200);
}

.card-table {
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	background: #fff;
	animation: fadeIn 1s ease;
}

.card-table table tbody tr {
	transition: background 0.2s, transform 0.2s;
	cursor: pointer;
}

.card-table table tbody tr:hover {
	background: rgba(102, 126, 234, 0.1);
	transform: translateY(-2px);
}

.badge-delivered {
	background-color: #28a745;
	color: #fff;
}

.badge-pending {
	background-color: #ffc107;
	color: #212529;
}

.badge-delayed {
	background-color: #dc3545;
	color: #fff;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@media ( max-width : 768px) {
	.sidebar {
		width: 60px;
		padding-top: 20px;
	}
	.sidebar a span {
		display: none;
	}
	.main-content {
		margin-left: 70px;
		margin-top: 80px;
		padding: 20px;
	}
}
</style>
</head>
<body>

	<jsp:include page="delivery-navbar.jsp"></jsp:include>

	<div class="sidebar">
		<a href="delivery-home"><i class="bi bi-house-door"></i> <span>Home</span></a>
		<a href="delivery-assigned.jsp"><i class="bi bi-box"></i> <span>Assigned
				Orders</span></a> <a href="delivery-history" class="active"><i
			class="bi bi-clock-history"></i> <span>Delivery History</span></a> <a
			href="profile.jsp"><i class="bi bi-person"></i> <span>Profile</span></a>
		<a href="logout"><i class="bi bi-box-arrow-right"></i> <span>Logout</span></a>
	</div>

	<div class="main-content">
		<div class="delivery-profile-row">
			<div class="profile-img">
				<img src="./images/delivery-avtar.jpg" alt="Delivery Person Photo">
			</div>
			<div class="profile-info">
				<h4><%=delivery.getName()%></h4>
				<p>Delivery Executive</p>
			</div>
		</div>

		<div class="stats-section">
			<div class="stat-card assigned">
				<div class="icon">
					<i class="bi bi-box"></i>
				</div>
				<h5>Assigned</h5>
				<h2 class="counter" data-target="<%=assignedCount%>">0</h2>
			</div>
			<div class="stat-card completed">
				<div class="icon">
					<i class="bi bi-check-circle"></i>
				</div>
				<h5>Completed</h5>
				<h2 class="counter" data-target="<%=completedCount%>">0</h2>
			</div>
			<div class="stat-card pending">
				<div class="icon">
					<i class="bi bi-hourglass-split"></i>
				</div>
				<h5>Pending</h5>
				<h2 class="counter" data-target="<%=pendingCount%>">0</h2>
			</div>
		</div>

		<div class="card-table">
			<h5 class="mb-3">📦 Delivery History</h5>
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
                    if (deliveries != null && !deliveries.isEmpty()) {
                        for (Map d : deliveries) {
                    %>
						<tr
							onclick="location.href='delivery-order-details.jsp?order_id=<%=d.get("order_id")%>'">
							<td><%=d.get("order_id")%></td>
							<td><%=d.get("customer_name")%></td>
							<td><%=d.get("customer_phone")%></td>
							<td><%=d.get("address")%></td>
							<td><%=d.get("products")%></td>
							<td><span
								class="badge <%="Completed".equals(d.get("status")) ? "badge-delivered" : "Pending".equals(d.get("status")) ? "badge-pending" : "badge-delayed"%>">
									<%=d.get("status")%>
							</span></td>
							<td><%=d.get("delivery_date")%></td>
						</tr>
						<%
                        }
                    } else {
                    %>
						<tr>
							<td colspan="7" class="text-center">No deliveries found 🚚</td>
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
const counters = document.querySelectorAll('.counter');
counters.forEach(counter => {
    const target = +counter.getAttribute('data-target');
    let count = 0;
    const increment = target / 100;
    const updateCounter = () => {
        count += increment;
        if(count < target) {
            counter.innerText = Math.ceil(count);
            requestAnimationFrame(updateCounter);
        } else {
            counter.innerText = target;
        }
    }
    updateCounter();
});
</script>
</body>
</html>
