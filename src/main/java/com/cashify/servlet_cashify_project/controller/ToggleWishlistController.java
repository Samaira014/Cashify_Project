package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.WishlistDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ToggleWishlistController")
public class ToggleWishlistController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("productId"));

        WishlistDao wishlistDao = new WishlistDao();
        wishlistDao.toggleWishlist(userId, productId);

        response.sendRedirect("wishlist.jsp"); 
    }
}

