package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dto.Seller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/SellerSettingsController")
public class SellerSettingsController extends HttpServlet {

    private final SellerDao sellerDao = new SellerDao();

    // Display the form (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("seller", seller); // forward seller data to JSP
        request.getRequestDispatcher("seller-settings.jsp").forward(request, response);
    }

    // Handle form submission (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        long phone = Long.parseLong(request.getParameter("phone"));
        String password = request.getParameter("password"); // leave blank to keep old password

        seller.setName(fullName);
        seller.setEmail(email);
        seller.setPhone(phone);

        if (password != null && !password.isEmpty()) {
            seller.setPassword(password);
        }

        boolean updated = sellerDao.updateSeller(seller); // implement this method in SellerDao

        if (updated) {
            session.setAttribute("successMsg", "Settings updated successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to update settings!");
        }

        // Redirect to GET to reload form with updated info
        response.sendRedirect("SellerSettingsController");
    }
}
