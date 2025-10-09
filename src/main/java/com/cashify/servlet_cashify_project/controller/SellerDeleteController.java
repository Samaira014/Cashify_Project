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


@WebServlet("/SellerDeleteController")
public class SellerDeleteController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Use seller object from session
            int sellerId = seller.getId();

            SellerDao dao = new SellerDao();
            boolean deleted = dao.deleteSeller(sellerId); // Make sure this method exists

            if (deleted) {
                session.invalidate(); // log out the user
                response.sendRedirect("login.jsp?msg=Account+deleted+successfully");
            } else {
                session.setAttribute("errorMsg", "Failed to delete account.");
                response.sendRedirect("seller-settings.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Internal server error: " + e.getMessage());
            response.sendRedirect("seller-settings.jsp");
        }
    }
}
