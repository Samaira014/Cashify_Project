package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.time.LocalDate;

import com.cashify.servlet_cashify_project.dao.AdminDao;
import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dto.Admin;
import com.cashify.servlet_cashify_project.dto.Seller;
import com.cashify.servlet_cashify_project.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class CashifyRegistrationController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        long phone  = Long.parseLong(req.getParameter("phone"));
        String role = req.getParameter("role");

        try {
            if ("user".equalsIgnoreCase(role)) {
                User user = new User(id, name, email, password, phone, LocalDate.now());
                User savedUser = new UserDao().saveUserDao(user);

                if (savedUser != null) {
                    resp.sendRedirect("login.jsp"); // redirect to login
                } else {
                    resp.getWriter().println("Failed to register User");
                }

            } else if ("admin".equalsIgnoreCase(role)) {
                Admin admin = new Admin(id, email, password);
                Admin savedAdmin = new AdminDao().saveAdmin(admin);

                if (savedAdmin != null) {
                    resp.sendRedirect("login.jsp");
                } else {
                    resp.getWriter().println("Failed to register Admin");
                }

            } else if ("seller".equalsIgnoreCase(role)) {
                Seller seller = new Seller(id, name, email, password, phone, LocalDate.now());
                boolean isSaved = new SellerDao().registerSeller(seller);

                if (isSaved) {
                    resp.sendRedirect("login.jsp"); // redirect to login page
                } else {
                    resp.getWriter().println("Failed to register Seller");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Something went wrong: " + e.getMessage());
        }
    }
}
