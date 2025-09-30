package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(value = "/logout")
public class AdminLogoutController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession httpSession = req.getSession();
		
		if(httpSession.getAttribute("adminSession")!=null) {
			
			httpSession.invalidate();
			
			req.setAttribute("msg", "you are logout successfully!!!");
			
			req.getRequestDispatcher("login.jsp").forward(req, resp);
		}
	}
}