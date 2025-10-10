package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.UserDao;
import com.cashify.servlet_cashify_project.dao.OrderDao;
import com.cashify.servlet_cashify_project.dto.User;
import com.cashify.servlet_cashify_project.dto.Order;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-users")
public class AdminUserController extends HttpServlet {

    private UserDao userDao = new UserDao();
    private OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	UserDao userDao = new UserDao();
        OrderDao orderDao = new OrderDao();

        // Get list of all users
        List<User> users = userDao.getAllUsers();
        request.setAttribute("users", users);

        // Set total users count
        int totalUsers = userDao.getTotalUsers();
        request.setAttribute("totalUsers", totalUsers);

        // Set purchased, returned, pending counts for dashboard cards
        int purchasedCount = orderDao.getAllOrders().size();
        int returnedCount = orderDao.getReturnedOrders().size();
        int pendingCount = orderDao.getOrdersByPaymentStatus("Pending").size();

        request.setAttribute("purchasedCount", purchasedCount);
        request.setAttribute("returnedCount", returnedCount);
        request.setAttribute("pendingCount", pendingCount);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("admin-user.jsp");
        rd.forward(request, response);
    }
}