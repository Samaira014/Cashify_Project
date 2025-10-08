<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="com.cashify.servlet_cashify_project.dao.SellOldPhoneDao"%>
<%@page import="com.cashify.servlet_cashify_project.dto.SellOldPhone"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Old Phones List</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h4 {
	text-align: center;
	margin: 20px 0;
	font-weight: bold;
	color: #333;
}

.table-container {
	max-width: 95%;
	margin: auto;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
	overflow-x: auto;
	padding: 20px;
	animation: fadeIn 1s ease-in-out;
}

table {
	border-collapse: collapse;
	width: 100%;
}

thead {
	background: linear-gradient(45deg, #0d6efd, #0dcaf0);
	color: white;
}

th, td {
	padding: 12px;
	text-align: center;
	vertical-align: middle;
}

tr {
	transition: all 0.3s ease;
}

tr:hover {
	background-color: #f1f9ff;
	transform: scale(1.01);
}

img {
	max-width: 80px;
	border-radius: 8px;
	transition: transform 0.3s ease;
}

img:hover {
	transform: scale(1.2);
}

.verify-form select, .verify-form input[type="submit"] {
	padding: 6px 10px;
	border-radius: 6px;
	border: 1px solid #ddd;
}

.verify-form input[type="submit"] {
	background: #0d6efd;
	color: #fff;
	border: none;
	cursor: pointer;
	transition: all 0.3s ease;
}
.verify-btn {
    transition: all 0.3s ease;
    font-weight: 600;
    border-radius: 8px;
}

.verify-btn:hover {
    transform: scale(1.08);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.btn-success {
    background-color: #28a745;
    border: none;
}

.btn-success:hover {
    background-color: #218838;
}

.btn-danger {
    background-color: #dc3545;
    border: none;
}

.btn-danger:hover {
    background-color: #c82333;
}


.verify-form input[type="submit"]:hover {
	background: #0b5ed7;
	transform: scale(1.05);
}

@
keyframes fadeIn {
	from {opacity: 0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<jsp:include page="admin-navbar.jsp"></jsp:include>

	<h4>User Product Details</h4>

	<div class="table-container">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>User</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Brand</th>
					<th>Model</th>
					<th>Storage</th>
					<th>Condition</th>
					<th>Expected Price</th>
					<th>Comments</th>
					<th>Image</th>
					<th>Verification</th>
				</tr>
			</thead>
			<tbody>
				<%
            SellOldPhoneDao dao = new SellOldPhoneDao();
            List<SellOldPhone> phones = dao.getAllOldPhones();

            if(phones != null && !phones.isEmpty()){
                for (SellOldPhone phone : phones) {
        %>
				<tr>
					<td><%= phone.getId() %></td>
					<td><%= phone.getName() %></td>
					<td><%= phone.getEmail() %></td>
					<td><%= phone.getPhone() %></td>
					<td><%= phone.getBrand() %></td>
					<td><%= phone.getModel() %></td>
					<td><%= phone.getStorage() %></td>
					<td><%= phone.getConditions() %></td>
					<td>₹<%= phone.getExpectedprice() %></td>
					<td><%= phone.getComments() %></td>
					<td>
						<%
                    byte[] imageBytes = phone.getImage();
                    if (imageBytes != null && imageBytes.length > 0) {
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                %> <img src="data:image/jpeg;base64,<%= base64Image %>"
						alt="Phone Image" /> <%
                    } else {
                %> <span class="text-muted">No Image</span> <%
                    }
                %>
					</td>
					<td>
						<form class="verify-form d-flex gap-2 justify-content-center"
							method="post" action="verifyOldPhone">
							<input type="hidden" name="id" value="<%= phone.getId() %>" /> <input
								type="hidden" name="status"
								value="<%=  "verified".equalsIgnoreCase(phone.getStatus()) ? "not verified" : "verified" %>" />

							<input type="submit"
								value="<%= "verified".equalsIgnoreCase(phone.getStatus()) ? "Mark Not Verified" : "Mark Verified" %>"
								class="btn btn-sm <%= "verified".equalsIgnoreCase(phone.getStatus()) ? "btn-danger" : "btn-success" %> verify-btn" />
						</form>
					</td>

				</tr>
				<%
                }
            } else {
        %>
				<tr>
					<td colspan="12" class="text-center text-muted">No records
						found.</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
