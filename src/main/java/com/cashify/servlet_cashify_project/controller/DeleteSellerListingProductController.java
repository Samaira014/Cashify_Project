package com.cashify.servlet_cashify_project.controller;
import com.cashify.servlet_cashify_project.dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/DeleteSellerListingProductController")
public class DeleteSellerListingProductController  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            ProductDao dao = new ProductDao();
            boolean isDeleted = dao.deleteProduct(productId);

            if (isDeleted) {
                session.setAttribute("successMsg", "Product removed successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to remove product!");
            }

            response.sendRedirect("seller-listing.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Internal server error: " + e.getMessage());
            response.sendRedirect("seller-listing.jsp");
        }
    }
}