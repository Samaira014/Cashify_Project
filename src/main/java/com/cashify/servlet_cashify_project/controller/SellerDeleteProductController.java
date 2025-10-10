package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.ProductDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete-product")
public class SellerDeleteProductController extends HttpServlet {
	    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		private ProductDao productDao = new ProductDao();

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String productIdStr = request.getParameter("productId");
	        if (productIdStr != null && !productIdStr.isEmpty()) {
	            try {
	                int productId = Integer.parseInt(productIdStr);
	                boolean deleted = productDao.deleteProduct(productId);
	                if (deleted) {
	                    request.getSession().setAttribute("msg", "Product deleted successfully!");
	                } else {
	                    request.getSession().setAttribute("msg", "Failed to delete product.");
	                }
	            } catch (NumberFormatException e) {
	                request.getSession().setAttribute("msg", "Invalid product ID.");
	            }
	        }
	        response.sendRedirect("seller-listing.jsp");
	    }
	}


