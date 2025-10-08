package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import com.cashify.servlet_cashify_project.dao.CartItemDao;
import com.cashify.servlet_cashify_project.dao.SellOldPhoneDao;
import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dto.Cart;
import com.cashify.servlet_cashify_project.dto.CartItems;
import com.cashify.servlet_cashify_project.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(value = "/cart")
public class CartItemController extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession httpSession = req.getSession();
		
		String email=(String) httpSession.getAttribute("userSession");
		
		if(email!=null) {
			User user=new UserDao().getUserByEmailDao(email);
			
			int productId = Integer.parseInt(req.getParameter("id"));
			
			int userId = user.getId();
			
			/**
			 * cart object created....
			 */
			Cart cart= new Cart();
			cart.setUserId(userId);
			
			cart.setStatus("pending");
			
			CartItemDao cartItemDao=new CartItemDao();
			
			cartItemDao.saveProductIntoCartDao(cart);
			
			/**
			 * to fetcch cart details
			 */
			Cart cart2=cartItemDao.getCartDetails(userId);
			
			
			/**
			 * to get the product price
			 */
			
			double productPrice=new SellOldPhoneDao().getOldPhonePriceByIdDao(productId);
			/**
			 * cartitems object created....
			 */
			CartItems cartItems = new CartItems();
			
			cartItems.setCartid(cart2.getId());
			cartItems.setDatetimes(LocalDateTime.now());
			cartItems.setProductid(productId);
			cartItems.setPrice(productPrice);
			cartItems.setQuantity(1);
			
			
			
			cartItemDao.saveCartItemsDao(cartItems);
			
			resp.sendRedirect("user-cart.jsp");
		}
		
		
	}
	
}