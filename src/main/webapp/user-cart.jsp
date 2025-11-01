<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cashify.servlet_cashify_project.dto.*"%>
<%@page import="com.cashify.servlet_cashify_project.dao.*"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart</title>
<style>
/* Responsive CSS */
.cart-container {
	width: 90%;
	margin: auto;
}

.cart-item {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	border-bottom: 1px solid #ccc;
	padding: 15px 0;
}

.cart-item img {
	width: 100px;
	height: auto;
	margin-right: 20px;
}

.item-info {
	flex: 2;
}

.item-actions {
	display: flex;
	align-items: center;
	gap: 10px;
}

@media ( max-width : 600px) {
	.cart-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.item-actions {
		margin-top: 10px;
	}
}

button {
	padding: 5px 10px;
}
</style>
</head>
<body>
	<div class="cart-container">
		<h2>Your Cart</h2>

		<%
			// Get existing session
			HttpSession httpSession  = request.getSession(false);

			if (httpSession == null || httpSession.getAttribute("userSession") == null) {
			    response.sendRedirect("login.jsp");
			    return;
			}

			String email = (String) httpSession.getAttribute("userSession");

			UserDao userDao = new UserDao();
			User user = userDao.getUserByEmailDao(email);

			if(user == null) {
			    response.sendRedirect("login.jsp");
			    return;
			}

			CartItemDao cartItemDao = new CartItemDao();
			Cart cart = cartItemDao.getCartDetails(user.getId());

			if(cart != null){
				List<CartItems> cartItems = cartItemDao.getCartItemsByCartId(cart.getId());

				if (cartItems == null || cartItems.isEmpty()) {
		%>
					<p>Your cart is empty.</p>
		<%
				} else {
					SellOldPhoneDao dao = new SellOldPhoneDao();
					for (CartItems items : cartItems) {
						SellOldPhone oldPhone = dao.getOldPhoneByIdDao(items.getProductid());
		%>
						<div class="cart-item">
							<img src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(oldPhone.getImage())%>" alt="Product Image" />
							<div class="item-info">
								<h4><%=oldPhone.getBrand()%></h4>
								<h4><%=oldPhone.getModel()%></h4>
								<p>Price: ₹<%=items.getPrice()%></p>
							</div>
							<div class="item-actions">
								<form action="decrementCartItems" method="post" style="display: inline;">
									<input type="hidden" name="itemsId" value="<%=items.getItemsid()%>" />
									<button name="action" value="decrease">-</button>
								</form>
								<span>Qty: <%=items.getQuantity()%></span>
								<form action="incrementCartItems" method="post" style="display: inline;">
									<input type="hidden" name="itemsId" value="<%=items.getItemsid()%>" />
									<button name="action" value="increase">+</button>
								</form>
							</div>
						</div>
		<%
					}
				}
			} else {
		%>
				<p>Your cart is empty.</p>
		<% } %>

		<form action="orderCartItems" method="get">
			<input type="submit" value="Buy Now">
		</form>
	</div>
</body>
</html>
