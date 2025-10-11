package com.cashify.servlet_cashify_project.controller;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class CashifyLogoutController  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // don't create new session

        if (session != null) {
            // Check role and invalidate session
            String role = (String) session.getAttribute("role");

            session.invalidate();

            // Redirect based on role
            if ("admin".equalsIgnoreCase(role)) {
                req.setAttribute("msg", "You have logged out successfully!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                
            } else if ("seller".equalsIgnoreCase(role)) {
                req.setAttribute("msg", "You have logged out successfully!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                
            } else if ("delivery".equalsIgnoreCase(role)) {
                req.setAttribute("msg", "You have logged out successfully!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                
            } else {
                // fallback
                req.setAttribute("msg", "You have logged out successfully!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("user-home.jsp");
        }
    }
}