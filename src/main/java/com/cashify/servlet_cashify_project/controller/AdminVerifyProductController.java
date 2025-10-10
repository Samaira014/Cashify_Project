package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cashify.servlet_cashify_project.dao.ProductDao;

@WebServlet("/AdminVerifyProductController")
public class AdminVerifyProductController extends HttpServlet {

    private ProductDao productDao = new ProductDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the 'id' parameter from the request
        String idStr = request.getParameter("id");

        // Check if the parameter is missing or empty
        if (idStr == null || idStr.trim().isEmpty() || idStr.equals("undefined")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing or invalid");
            return;
        }

        try {
            int productId = Integer.parseInt(idStr);

            // Call your DAO method to verify the product
            boolean success = productDao.verifyProduct(productId);

            if (success) {
                response.getWriter().write("Product verified successfully!");
            } else {
                response.getWriter().write("Failed to verify product. Maybe the ID is invalid?");
            }

        } catch (NumberFormatException e) {
            // Handle the case where the parameter is not a number
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID must be a valid number");
        }
    }
}
