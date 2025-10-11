package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.AdminDao;
import com.cashify.servlet_cashify_project.dao.DeliveryPersonDao;
import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dto.Admin;
import com.cashify.servlet_cashify_project.dto.DeliveryPerson;
import com.cashify.servlet_cashify_project.dto.Seller;
import com.cashify.servlet_cashify_project.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(value = "/login")
public class CashifyLoginController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession httpSession = req.getSession();

		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");

		if (role.equalsIgnoreCase("admin")) {
		    Admin admin = new AdminDao().getAdminByEmailDao(email);

		    if (admin != null && admin.getPassword().equals(password)) {
		        // ✅ Store the full object
		        httpSession.setAttribute("admin", admin);
		        System.out.println("admin-logged in successfully");

		        resp.sendRedirect("admin-home.jsp"); // or forward
		    } else {
		        req.setAttribute("msg", "please check with your credentials");
		        req.getRequestDispatcher("login.jsp").forward(req, resp);
		    }

			
		} else if (role.equalsIgnoreCase("seller")) {
			Seller seller = new SellerDao().loginSeller(email, password);

			if (seller != null) {
			    // ✅ store the full object, not just email
			    httpSession.setAttribute("seller", seller); 
			    req.getRequestDispatcher("seller-home.jsp").forward(req, resp);
			} else {
			    req.setAttribute("msg", "Please check your credentials");
			    req.getRequestDispatcher("login.jsp").forward(req, resp);
			}
		} else if (role.equalsIgnoreCase("deliveryperson")) {
			 DeliveryPerson dp = new DeliveryPersonDao().getByEmail(email);
			    if (dp != null && dp.getPassword().equals(password)) {
			        httpSession.setAttribute("deliveryPerson", dp); // ✅ match JSP
			        httpSession.setAttribute("role", "delivery");
			        resp.sendRedirect("delivery-home"); // ✅ controller handles JSP
			    } else {
			        req.setAttribute("msg", "Please check your credentials");
			        req.getRequestDispatcher("login.jsp").forward(req, resp);
			    }
		} else {

			User user = new UserDao().getUserByEmailDao(email);

			if (user != null && user.getPassword().equals(password)) {

				httpSession.setAttribute("userSession", email);

				System.out.println("user-logged in successfully");

				req.getRequestDispatcher("user-home.jsp").forward(req, resp);

			} else {

				System.out.println("check with user credentials!!!!");

				req.setAttribute("msg", "please check with your credentials");
				req.getRequestDispatcher("login.jsp").forward(req, resp);
			}
		}
	}
}