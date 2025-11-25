package com.cashify.servlet_cashify_project.controller;



import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.dao.WishlistDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/wishlist")
public class WishlistController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            res.setStatus(401); // Not logged in
            res.getWriter().write("{\"error\": \"Not Logged In\"}");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String productParam = req.getParameter("productId");
        if (productParam == null) {
            res.setStatus(400);
            res.getWriter().write("{\"error\": \"Missing productId\"}");
            return;
        }

        int productId = Integer.parseInt(productParam);

        WishlistDao dao = new WishlistDao();
        boolean added = dao.toggleWishlist(userId, productId);

        res.getWriter().write("{\"success\": true, \"added\": " + added + "}");
    }
}
