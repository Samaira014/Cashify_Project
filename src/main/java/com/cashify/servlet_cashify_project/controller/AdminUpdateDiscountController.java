package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.ProductDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/AdminUpdateDiscountController")
public class AdminUpdateDiscountController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
    private ProductDao dao = new ProductDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            double discountedPrice = Double.parseDouble(request.getParameter("discountedPrice"));

            boolean updated = dao.updateDiscountedPrice(productId, discountedPrice);

            if (updated) {
                // Redirect to admin pending items page
                response.sendRedirect("admin-seller.jsp"); 
            } else {
                response.getWriter().println("<h3 style='color:red'>Failed to update discounted price!</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red'>Invalid input!</h3>");
        }
    }
}


