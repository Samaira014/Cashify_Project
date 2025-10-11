package com.cashify.servlet_cashify_project.controller;


import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/product-image")
public class ProductImageController extends HttpServlet {
	 private ProductDao productDao = new ProductDao();

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws IOException {
	        try {
	            int id = Integer.parseInt(request.getParameter("id"));
	            byte[] imageData = productDao.getImage(id);

	            if (imageData != null) {
	                response.setContentType("image/jpeg");
	                response.getOutputStream().write(imageData);
	            } else {
	                // Optional: fallback image if null
	                response.sendRedirect(request.getContextPath() + "/images/no-image.jpg");
	            }
	        } catch (NumberFormatException e) {
	            response.sendRedirect(request.getContextPath() + "/images/no-image.jpg");
	        }
	    }
	}