package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.time.LocalDate;

import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dto.Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/seller-register")
public class SellerRegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Get data from registration form
        int id = Integer.parseInt(req.getParameter("id")); // you can use auto-increment in DB instead
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        long phone = Long.parseLong(req.getParameter("phone"));

        // Create Seller object
        Seller seller = new Seller(id, name, email, password, phone, LocalDate.now());

        // Save to database
        boolean isSaved = new SellerDao().registerSeller(seller);

        if (isSaved) {
            // Redirect to login page after successful registration
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("msg", "Registration failed! Please try again.");
            req.getRequestDispatcher("registration.jsp").forward(req, resp);
        }
    }
}

