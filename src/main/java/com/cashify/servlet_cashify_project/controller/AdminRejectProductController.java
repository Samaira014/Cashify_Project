package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.ProductDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/RejectProductByAdmin")
public class AdminRejectProductController extends HttpServlet{

	private ProductDao dao = new ProductDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String reason = request.getParameter("reason");

        boolean updated = dao.rejectProduct(productId, reason);

        if (updated) {
            response.sendRedirect("seller-listing.jsp");
        } else {
            response.getWriter().println("Failed to reject product");
        }
    }
}
