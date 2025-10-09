package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dto.Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SellerSettingsController")
public class SellerSettingsController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneStr = request.getParameter("phone");
            String password = request.getParameter("password"); // optional

            // Validate and parse phone
            long phone = 0;
            try {
                phone = Long.parseLong(phoneStr);
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Invalid phone number!");
                response.sendRedirect("seller-settings.jsp");
                return;
            }

            // Update seller object
            seller.setName(fullName);
            seller.setEmail(email);
            seller.setPhone(phone);

            if (password != null && !password.trim().isEmpty()) {
                seller.setPassword(password); // only update if not empty
            }

            // Save to database
            SellerDao dao = new SellerDao();
            boolean updated = dao.updateSeller(seller);

            if (updated) {
                session.setAttribute("successMsg", "Settings updated successfully!");
                session.setAttribute("seller", seller); // update session
            } else {
                session.setAttribute("errorMsg", "Failed to update settings.");
            }

            response.sendRedirect("seller-settings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Internal server error: " + e.getMessage());
            response.sendRedirect("seller-settings.jsp");
        }
    }
}
