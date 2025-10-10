<%@page import="com.cashify.servlet_cashify_project.dao.ProductDao"%>
<%@page import="com.cashify.servlet_cashify_project.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ProductDao dao = new ProductDao();
List<Product> products = dao.getAllProducts();
%>
<%
List<Map<String, String>> sellers = (List<Map<String, String>>) request.getAttribute("sellers");
int totalSellers = (sellers != null) ? sellers.size() : 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Sellers</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">

<style>
/* Layout */
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
	gap: 8px;
	font-weight: 500;
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

/* Cards */
.stats {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	margin-bottom: 20px;
}

.card-stats {
	flex: 1;
	min-width: 180px;
	border-radius: 14px;
	color: white;
	padding: 20px;
	text-align: center;
	cursor: pointer;
	position: relative;
	overflow: hidden;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
}

.card-stats:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
}

.card-stats i {
	font-size: 2.5rem;
	position: absolute;
	top: 10px;
	right: 15px;
	opacity: 0.3;
}

.bg-sellers {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.bg-pending {
	background: linear-gradient(135deg, #ff512f, #dd2476);
}

.bg-approved {
	background: linear-gradient(135deg, #00b09b, #96c93d);
}

.bg-sold {
	background: linear-gradient(135deg, #1fa2ff, #12d8fa);
}

/* Sections */
.section {
	display: none;
	margin-top: 15px;
}

.table-container {
	background: white;
	border-radius: 12px;
	padding: 15px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	overflow-x: auto;
}

/* Product table */
.table img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
}

input.form-control-sm {
	max-width: 100px;
}

/* Responsive */
@media ( max-width : 768px) {
	.content {
		margin-left: 0;
		margin-top: 65px;
	}
	.sidebar {
		width: 100%;
		position: relative;
		padding-top: 0;
		height: auto;
	}
	.stats {
		flex-direction: column;
	}
	.table img {
		width: 60px;
		height: 60px;
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
			<a href="admin-home.jsp"><i class="fa-solid fa-house"></i>
				Dashboard</a> <a href="admin-user.jsp"><i class="fa-solid fa-users"></i>
				Users</a> <a href="admin-seller.jsp" class="active"><i
				class="fa-solid fa-store"></i> Sellers</a> <a href="admin-delivery.jsp"><i
				class="fa-solid fa-truck"></i> Delivery</a>
		</div>

		<!-- Content -->
		<div class="content">
			<!-- Dashboard Cards -->
			<div class="stats">
				<div class="carousel card-stats bg-sellers"
					onclick="showSection('totalSellersDiv')">
					<h5>Total Sellers</h5>
					<h3><%=request.getAttribute("totalSellers") != null ? request.getAttribute("totalSellers") : 0%></h3>
					<i class="fa-solid fa-store"></i>
				</div>

				<div class="card-stats bg-pending"
					onclick="showSection('pendingDiv')">
					<h5>Pending Items</h5>
					<h3><%=request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : 0%></h3>
					<i class="fa-solid fa-hourglass-half"></i>
				</div>

				<div class="card-stats bg-approved"
					onclick="showSection('approvedDiv')">
					<h5>Approved Items</h5>
					<h3><%=request.getAttribute("approvedCount") != null ? request.getAttribute("approvedCount") : 0%></h3>
					<i class="fa-solid fa-circle-check"></i>
				</div>

				<div class="card-stats bg-sold" onclick="showSection('soldDiv')">
					<h5>Sold Items</h5>
					<h3><%=request.getAttribute("soldCount") != null ? request.getAttribute("soldCount") : 0%></h3>
					<i class="fa-solid fa-cart-shopping"></i>
				</div>
			</div>

			<!-- Sections -->
			<div id="totalSellersDiv" class="section">
				<div class="table-container">
					<h5>All Sellers</h5>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (sellers != null && !sellers.isEmpty()) {
								    for (Map<String, String> s : sellers) {
								%>
							<tr>
								<td><%=s.get("id")%></td>
								<td><%=s.get("name")%></td>
								<td><%=s.get("email")%></td>
								<td><%=s.get("phone")%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="4" class="text-center">No sellers found</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<div id="pendingDiv" class="section">
    <div class="table-container">
        <h5>Pending Items</h5>
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Brand</th>
                    <th>Seller ID</th>
                    <th>Price</th>
                    <th>Discounted Price</th>
                    <th>Verified</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (products == null || products.isEmpty()) {
                %>
                <tr>
                    <td colspan="8" class="text-center text-muted">No products found.</td>
                </tr>
                <%
                } else {
                    for (Product p : products) {
                %>
                <tr>
                    <td>
                        <img src="<%=(p.getImage() != null)
                                ? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(p.getImage())
                                : "https://via.placeholder.com/80"%>"
                             alt="<%=p.getProductName()%>">
                    </td>
                    <td><%=p.getProductName()%></td>
                    <td><%=p.getBrand()%></td>
                    <td><%=p.getSellerId()%></td>
                    <td>₹<%=p.getPrice()%></td>
                    <td>
                        <input type="number" class="form-control form-control-sm"
                               value="<%= (p.getDiscountedPrice() != null) ? p.getDiscountedPrice() : "" %>"
                               placeholder="₹"
                               onblur="updateDiscount(<%=p.getId()%>, this)">
                    </td>
                    <td>
                        <% if (p.isVerified()) { %>
                            <span class="badge bg-success">Yes</span>
                        <% } else if (p.getRejection_msg() != null) { %>
                            <span class="badge bg-danger">Rejected</span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                        <% } %>
                    </td>
                    <td id="actionCell-<%=p.getId()%>">
                        <% if (!p.isVerified() && p.getRejection_msg() == null) { %>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">Action</button>
                                <ul class="dropdown-menu p-2">
                                    <li>
                                        <button type="button" class="btn btn-sm btn-success w-100"
                                                onclick="verifyProduct(<%=p.getId()%>)">
                                            <i class="fa-solid fa-check"></i> Verify
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="btn btn-sm btn-danger w-100"
                                                onclick="toggleRejectBox('<%=p.getId()%>')">
                                            <i class="fa-solid fa-xmark"></i> Reject
                                        </button>
                                    </li>
                                </ul>
                            </div>
                            <form id="rejectBox-<%=p.getId()%>" style="display:none; margin-top:5px;" onsubmit="rejectProduct(<%=p.getId()%>); return false;">
                                <textarea class="form-control mb-1" placeholder="Reason" required></textarea>
                                <button class="btn btn-sm btn-primary w-100">Submit</button>
                            </form>
                        <% } else if (p.isVerified()) { %>
                            <button type="button" class="btn btn-sm btn-warning w-100" onclick="unverifyProduct(<%=p.getId()%>)">
                                Undo Verify
                            </button>
                        <% } else if (p.getRejection_msg() != null) { %>
                            <button type="button" class="btn btn-sm btn-info w-100" onclick="unrejectProduct(<%=p.getId()%>)">
                                Undo Reject
                            </button>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>

			<div id="approvedDiv" class="section">
				<div class="table-container">
					<h5>Approved Items</h5>
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Product</th>
								<th>Seller</th>
							</tr>
						</thead>
						<tbody>
							<%
									List<Map<String, String>> approvedItems = (List<Map<String, String>>) request.getAttribute("approvedItems");
									if (approvedItems != null) {
										for (Map<String, String> a : approvedItems) {
									%>
							<tr>
								<td><%=a.get("id")%></td>
								<td><%=a.get("product")%></td>
								<td><%=a.get("sellerName")%></td>
							</tr>
							<%
									}
									} else {
									%>
							<tr>
								<td colspan="3" class="text-center">No approved items</td>
							</tr>
							<%
									}
									%>
						</tbody>
					</table>
				</div>
			</div>

			<div id="soldDiv" class="section">
				<div class="table-container">
					<h5>Sold Items</h5>
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Product</th>
								<th>Seller</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Map<String, String>> soldItems = (List<Map<String, String>>) request.getAttribute("soldItems");
							if (soldItems != null) {
								for (Map<String, String> s : soldItems) {
							%>
							<tr>
								<td><%=s.get("id")%></td>
								<td><%=s.get("product")%></td>
								<td><%=s.get("sellerName")%></td>
								<td><%=s.get("status")%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="4" class="text-center">No sold items</td>
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
// Show/hide sections
function showSection(id){
    document.querySelectorAll('.section').forEach(s => s.style.display = 'none');
    document.getElementById(id).style.display = 'block';
}

// Toggle reject textarea
function toggleRejectBox(id){
    var box = document.getElementById('rejectBox-' + id);
    box.style.display = (box.style.display === 'none') ? 'block' : 'none';
}

// AJAX Verify
function verifyProduct(id){
    fetch('VerifyProductController', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id
    }).then(res=>{
        if(res.ok){
            const cell = document.getElementById('actionCell-'+id);
            cell.innerHTML='<span class="badge bg-success">Verified</span>';
        }
    });
}

// AJAX Unverify
function unverifyProduct(id){
    fetch('UnverifyProductController', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id
    }).then(res=>{
        if(res.ok){
            const cell = document.getElementById('actionCell-'+id);
            cell.innerHTML=`
                <div class="dropdown">
                    <button class="btn btn-sm btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">Action</button>
                    <ul class="dropdown-menu p-2">
                        <li>
                            <form onsubmit="verifyProduct(${id}); return false;" class="mb-1">
                                <button type="submit" class="btn btn-sm btn-success w-100"><i class="fa-solid fa-check"></i> Verify</button>
                            </form>
                        </li>
                        <li>
                            <button type="button" class="btn btn-sm btn-danger w-100" onclick="toggleRejectBox('${id}')"><i class="fa-solid fa-xmark"></i> Reject</button>
                        </li>
                    </ul>
                </div>
                <form id="rejectBox-${id}" style="display:none; margin-top:5px;" onsubmit="rejectProduct(${id}); return false;">
                    <textarea class="form-control mb-1" placeholder="Reason" required></textarea>
                    <button class="btn btn-sm btn-primary w-100">Submit</button>
                </form>
            `;
        }
    });
}

// AJAX Reject
function rejectProduct(id){
    const reason = document.querySelector('#rejectBox-'+id+' textarea').value;
    fetch('RejectProductByAdmin', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id+'&reason='+encodeURIComponent(reason)
    }).then(res=>{
        if(res.ok){
            const cell = document.getElementById('actionCell-'+id);
            cell.innerHTML=`<span class="badge bg-danger">Rejected: ${reason}</span>`;
        }
    });
}

// AJAX Unreject
function unrejectProduct(id){
    fetch('UnrejectProductController', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id
    }).then(res=>{
        if(res.ok){
            const cell = document.getElementById('actionCell-'+id);
            cell.innerHTML=`
                <div class="dropdown">
                    <button class="btn btn-sm btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">Action</button>
                    <ul class="dropdown-menu p-2">
                        <li>
                            <form onsubmit="verifyProduct(${id}); return false;" class="mb-1">
                                <button type="submit" class="btn btn-sm btn-success w-100"><i class="fa-solid fa-check"></i> Verify</button>
                            </form>
                        </li>
                        <li>
                            <button type="button" class="btn btn-sm btn-danger w-100" onclick="toggleRejectBox('${id}')"><i class="fa-solid fa-xmark"></i> Reject</button>
                        </li>
                    </ul>
                </div>
                <form id="rejectBox-${id}" style="display:none; margin-top:5px;" onsubmit="rejectProduct(${id}); return false;">
                    <textarea class="form-control mb-1" placeholder="Reason" required></textarea>
                    <button class="btn btn-sm btn-primary w-100">Submit</button>
                </form>
            `;
        }
    });
}

// AJAX Discount Update
function updateDiscount(productId, input){
    const value = input.value;
    fetch('AdminUpdateDiscountController', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+productId+'&discountedPrice='+value
    }).then(res=>{
        if(res.ok){
            input.classList.add('is-valid');
            setTimeout(()=>input.classList.remove('is-valid'), 1000);
        } else {
            input.classList.add('is-invalid');
            setTimeout(()=>input.classList.remove('is-invalid'), 1000);
        }
    });
}
</script>



</body>
</html>
