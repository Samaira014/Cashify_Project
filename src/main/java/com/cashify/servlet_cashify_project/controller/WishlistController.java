package com.cashify.servlet_cashify_project.controller;



import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistController extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pid = req.getParameter("productId");
        if (pid == null) {
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }
        int productId = Integer.parseInt(pid);
        HttpSession session = req.getSession();
        List<Integer> wishlist = (List<Integer>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
            session.setAttribute("wishlist", wishlist);
        }
        if (!wishlist.contains(productId)) wishlist.add(productId);
        resp.sendRedirect(req.getHeader("Referer"));
    }
}

