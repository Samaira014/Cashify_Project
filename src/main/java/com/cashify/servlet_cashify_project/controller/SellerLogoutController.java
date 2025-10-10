package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sellerLogout")
public class SellerLogoutController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get existing session, don't create new
        if (session != null) {
            session.invalidate(); // Log out the user
        }

        // Redirect to login page with optional message
        response.sendRedirect("login.jsp?msg=Logged+out+successfully");
    }
}
