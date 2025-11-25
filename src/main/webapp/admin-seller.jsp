<%@page import="com.cashify.servlet_cashify_project.dto.Seller"%>
<%@page import="com.cashify.servlet_cashify_project.dao.SellerDao"%>
<%@page import="com.cashify.servlet_cashify_project.dao.ProductDao"%>
<%@page import="com.cashify.servlet_cashify_project.dto.Product"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

List<Product> pendingProducts = (List<Product>) request.getAttribute("pendingProducts");
List<Product> approvedProducts = (List<Product>) request.getAttribute("approvedProducts");
List<Product> rejectedProducts = (List<Product>) request.getAttribute("rejectedProducts");
List<Product> soldProducts = (List<Product>) request.getAttribute("soldProducts");

SellerDao sellerDao = new SellerDao();
List<Seller> sellers = sellerDao.getAllSellers();

int totalSellers = (sellers != null) ? sellers.size() : 0;
int totalPendingProducts = (pendingProducts != null) ? pendingProducts.size() : 0;
int totalApprovedProducts = (approvedProducts != null) ? approvedProducts.size() : 0;
int totalRejectedProducts = (rejectedProducts != null) ? rejectedProducts.size() : 0;
int totalSoldProducts = (soldProducts != null) ? soldProducts.size() : 0;

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

.image{
margin: auto; 
display: flex;
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
.bg-rejected{
background:linear-gradient(180deg,#2f71a1,#6ecfde);
}

.bg-sold {
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
	overflow-x: auto;
}

.table img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
}

input.form-control-sm {
	max-width: 100px;
}

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
				Users</a> <a href="${pageContext.request.contextPath}/admin-seller" class="active"><i
				class="fa-solid fa-store"></i> Sellers</a> <a href="admin-delivery.jsp"><i
				class="fa-solid fa-truck"></i> Delivery</a>
		</div>

		<!-- Content -->
		<div class="content">
			<!-- Dashboard Cards -->
			<div class="stats">
				<div class="card-stats bg-sellers"
					onclick="showSection('totalSellersDiv')">
					<h5>Total Sellers</h5>
					<h3><%=totalSellers%></h3>
					<i class="fa-solid fa-store"></i>
				</div>
				<div class="card-stats bg-pending"
					onclick="showSection('pendingDiv')">
					<h5>Pending Items</h5>
					<h3><%=totalPendingProducts%></h3>
					<i class="fa-solid fa-hourglass-half"></i>
				</div>
				<div class="card-stats bg-approved"
					onclick="showSection('approvedDiv')">
					<h5>Approved Items</h5>
					<h3><%=totalApprovedProducts%></h3>
					<i class="fa-solid fa-circle-check"></i>
				</div>
				<div class="card-stats bg-rejected" 
				onclick="showSection('rejectedDiv')">
				<h5>Rejected Items</h5>
				<h3><%=totalRejectedProducts%></h3>
				<i class="fa-solid fa-ban"></i>
			</div>
				<div class="card-stats bg-sold" onclick="showSection('soldDiv')">
					<h5>Sold Items</h5>
					<h3><%=totalSoldProducts%></h3>
					<i class="fa-solid fa-cart-shopping"></i>
				</div>
			</div>

			<!-- Total Sellers -->
			<div id="totalSellersDiv" class="section" style="display: block;">
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
              for (Seller s : sellers) {
            %>
							<tr>
								<td><%=s.getId()%></td>
								<td><%=s.getName()%></td>
								<td><%=s.getEmail()%></td>
								<td><%=s.getPhone()%></td>
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

			<!-- Pending Products -->
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
            if (pendingProducts == null || pendingProducts.isEmpty()) {
            %>
							<tr>
								<td colspan="8" class="text-center text-muted">No pending
									products.</td>
							</tr>
							<%
            } else {
              for (Product p : pendingProducts) {
            %>
							<tr>
								<td ><img class="image"
									src="<%=(p.getImage()!=null)?"data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(p.getImage()):"https://via.placeholder.com/80"%>"
									alt="<%=p.getProductName()%>"></td>
								<td><%=p.getProductName()%></td>
								<td><%=p.getBrand()%></td>
								<td><%=p.getSellerId()%></td>
								<td>₹<%=p.getPrice()%></td>
								<td><input type="number"
									class="form-control form-control-sm"
									value="<%=(p.getDiscountedPrice()!=null?p.getDiscountedPrice():"")%>"
									placeholder="₹" onblur="updateDiscount(<%=p.getId()%>, this)"></td>
								<td>
									<%
                if(p.isVerified()){ %> <span class="badge bg-success">Yes</span>
									<% 
                } else if(p.getRejection_msg()!=null){ %> <span
									class="badge bg-danger">Rejected</span> <% 
                } else { %> <span class="badge bg-warning text-dark">Pending</span>
									<% } %>
								</td>
								<td id="actionCell-<%=p.getId()%>" style="display: flex;  gap: 5px; margin-top: 23px;">
									<%
                if(!p.isVerified() && p.getRejection_msg()==null){ %>
                					<button class="btn btn-sm btn-success w-100"
													onclick="verifyProduct(<%=p.getId()%>)">
													<i class="fa-solid fa-check"></i> Verify
												</button>
												<button class="btn btn-sm btn-danger w-100"
													onclick="toggleRejectBox('<%=p.getId()%>')">
													<i class="fa-solid fa-xmark"></i> Reject
												</button>
									
									<form id="rejectBox-<%=p.getId()%>"
										style="display: none; margin-top: 5px;"
										onsubmit="rejectProduct(<%=p.getId()%>); return false;">
										<textarea class="form-control mb-1" placeholder="Reason"
											required></textarea>
										<button class="btn btn-sm btn-primary w-100">Submit</button>
									</form> <% } else if(p.isVerified()){ %>
									<button type="button" class="btn btn-sm btn-warning w-100"
										onclick="unverifyProduct(<%=p.getId()%>)">Undo Verify</button>
									<% } else if(p.getRejection_msg()!=null){ %>
									<button type="button" class="btn btn-sm btn-info w-100"
										onclick="unrejectProduct(<%=p.getId()%>)">Undo Reject</button>
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

			<!-- Approved Products -->
			<div id="approvedDiv" class="section">
				<div class="table-container">
					<h5>Approved Items</h5>
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
            if(approvedProducts==null || approvedProducts.isEmpty()){ %>
							<tr>
								<td colspan="8" class="text-center text-muted">No approved
									products.</td>
							</tr>
							<%
            } else {
              for(Product p : approvedProducts){ %>
							<tr>
								<td><img class="image"
									src="<%=(p.getImage()!=null)?"data:image/jpeg;base64,"+java.util.Base64.getEncoder().encodeToString(p.getImage()):"https://via.placeholder.com/80"%>"
									alt="<%=p.getProductName()%>"></td>
								<td><%=p.getProductName()%></td>
								<td><%=p.getBrand()%></td>
								<td><%=p.getSellerId()%></td>
								<td>₹<%=p.getPrice()%></td>
								<td><input type="number"
									class="form-control form-control-sm"
									value="<%=(p.getDiscountedPrice()!=null?p.getDiscountedPrice():"")%>"
									placeholder="₹" onblur="updateDiscount(<%=p.getId()%>, this)"></td>
								<td><span class="badge bg-success">Yes</span></td>
								<td><button type="button"
										class="btn btn-sm btn-warning w-100"
										onclick="unverifyProduct(<%=p.getId()%>)">Undo Verify</button></td>
							</tr>
							<%
              }
            }
            %>
						</tbody>
					</table>
				</div>
			</div>
			<!-- ✅ Rejected Products -->
		<div id="rejectedDiv" class="section">
			<div class="table-container">
				<h5>Rejected Items</h5>
				<table class="table table-bordered table-hover align-middle">
					<thead class="table-light">
						<tr>
							<th>Image</th>
							<th>Product Name</th>
							<th>Brand</th>
							<th>Seller ID</th>
							<th>Price</th>
							<th>Rejection Reason</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						if(rejectedProducts==null || rejectedProducts.isEmpty()){ %>
							<tr><td colspan="7" class="text-center text-muted">No rejected products.</td></tr>
						<%
						}else{
							for(Product p:rejectedProducts){ %>
							<tr>
								<td><img class="image" src="<%=(p.getImage()!=null)?"data:image/jpeg;base64,"+java.util.Base64.getEncoder().encodeToString(p.getImage()):"https://via.placeholder.com/80"%>" alt="<%=p.getProductName()%>"></td>
								<td><%=p.getProductName()%></td>
								<td><%=p.getBrand()%></td>
								<td><%=p.getSellerId()%></td>
								<td>₹<%=p.getPrice()%></td>
								<td><%=p.getRejection_msg()%></td>
								<td><button class="btn btn-sm btn-info w-100" onclick="unrejectProduct(<%=p.getId()%>)">Undo Reject</button></td>
							</tr>
						<% } } %>
					</tbody>
				</table>
			</div>
		</div>

			<!-- Sold Products -->
			<div id="soldDiv" class="section">
				<div class="table-container">
					<h5>Sold Items</h5>
					<table class="table table-bordered table-hover align-middle">
						<thead class="table-light">
							<tr>
								<th>Image</th>
								<th>Product Name</th>
								<th>Brand</th>
								<th>Seller ID</th>
								<th>Price</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
            if(soldProducts==null || soldProducts.isEmpty()){ %>
							<tr>
								<td colspan="6" class="text-center text-muted">No sold
									products.</td>
							</tr>
							<%
            } else {
              for(Product p : soldProducts){ %>
							<tr>
								<td><img class="image"
									src="<%=(p.getImage()!=null)?"data:image/jpeg;base64,"+java.util.Base64.getEncoder().encodeToString(p.getImage()):"https://via.placeholder.com/80"%>"
									alt="<%=p.getProductName()%>"></td>
								<td><%=p.getProductName()%></td>
								<td><%=p.getBrand()%></td>
								<td><%=p.getSellerId()%></td>
								<td>₹<%=p.getPrice()%></td>
								<td><span class="badge bg-primary">Sold</span></td>
							</tr>
							<%
              }
            }
            %>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
// Show/hide sections
function showSection(id) {
  document.querySelectorAll('.section').forEach(s => s.style.display = 'none');
  const section = document.getElementById(id);
  if (section) section.style.display = 'block';
}

// Toggle reject textarea
function toggleRejectBox(id){
  const box = document.getElementById('rejectBox-'+id);
  box.style.display = (box.style.display==='none')?'block':'none';
}

// AJAX Verify
function verifyProduct(id) {
  fetch('AdminVerifyProductController', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'productId=' + id
  })
  .then(res => {
    if (res.ok) {
      // Find the pending row
      const row = document.querySelector(`#actionCell-${id}`).closest('tr');
      // Update verified badge
      row.querySelector('td:nth-child(7)').innerHTML = '<span class="badge bg-success">Yes</span>';
      // Remove action buttons and add Undo Verify button
      document.getElementById('actionCell-' + id).innerHTML = `
        <button type="button" class="btn btn-sm btn-warning w-100" onclick="unverifyProduct(${id})">
          Undo Verify
        </button>`;
      // Move to Approved table
      document.querySelector('#approvedDiv tbody').appendChild(row);
    } else {
      alert('Failed to verify product');
    }
  })
  .catch(err => console.error('Error:', err));
}



// AJAX Unverify
function unverifyProduct(id){
  fetch('UnverifyProductController',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'productId='+id})
  .then(res=>{ if(res.ok){ location.reload(); } });
}

// AJAX Reject
function rejectProduct(id){
  const reason = document.querySelector('#rejectBox-'+id+' textarea').value;
  if(!reason.trim()){ alert("Please enter a reason"); return; }
  fetch('RejectProductByAdmin',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'productId='+id+'&reason='+encodeURIComponent(reason)})
  .then(res=>{ if(res.ok){ location.reload(); } });
}

// AJAX Unreject
function unrejectProduct(id){
  fetch('UnrejectProductController',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'productId='+id})
  .then(res=>{ if(res.ok){ location.reload(); } });
}

// AJAX Discount Update
function updateDiscount(productId,input){
  const value = parseFloat(input.value);
  if(value<=0){ alert("Invalid Discount"); return; }
  fetch('AdminUpdateDiscountController',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'productId='+productId+'&discountedPrice='+value})
  .then(res=>{ if(res.ok){ input.classList.add('is-valid'); setTimeout(()=>input.classList.remove('is-valid'),1000); } else { input.classList.add('is-invalid'); setTimeout(()=>input.classList.remove('is-invalid'),1000); } });
}
</script>
</body>
</html>
