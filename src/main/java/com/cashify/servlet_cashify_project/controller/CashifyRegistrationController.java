package com.cashify.servlet_cashify_project.controller;



import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(value="/register")
public class CashifyRegistrationController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		long phone = Long.parseLong(req.getParameter("phone"));
		
		String role = req.getParameter("role");
		
		if(role.equalsIgnoreCase("user")) {
			
			//userDao
			
			User user = new User(id, name, email, password, phone);
			
			User user2 = new UserDao().saveUserDao(user);
			
			if(user2 != null) {
				System.out.println("User Registered success ");
				req.getRequestDispatcher("login.jsp").forward(req, resp);
			}
		}else if(role.equalsIgnoreCase("seller")){
			//seller dao
			
		}else {
			//delivery person
		}
	}

}
