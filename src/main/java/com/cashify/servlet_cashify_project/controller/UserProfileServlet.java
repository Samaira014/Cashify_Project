package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user-profile")
public class UserProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userSession") != null) {
            String email = (String) session.getAttribute("userSession");
            
            User user = new UserDao().getUserByEmailDao(email); // fetch user from DB
            
            request.setAttribute("user", user); // pass to JSP
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); // not logged in
        }
    }
}

