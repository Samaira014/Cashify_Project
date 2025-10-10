package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.util.List;

import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dto.Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminSellers")
public class AdminSellerController extends HttpServlet {

    private SellerDao sellerDao = new SellerDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all sellers
    	// Fetch all sellers
        List<Seller> sellers = sellerDao.getAllSellers();
        int totalSellers = sellerDao.getTotalSellers();

        // Set data as request attributes
        request.setAttribute("sellers", sellers);
        request.setAttribute("totalSellers", totalSellers);


        // Forward to JSP page
        request.getRequestDispatcher("admin-sellers.jsp").forward(request, response);
    }
}
