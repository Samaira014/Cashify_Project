package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.util.Map;

import com.cashify.servlet_cashify_project.dao.DeliveryPersonDao;
import com.cashify.servlet_cashify_project.dto.DeliveryPerson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delivery-home")
public class DeliveryHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get current session, don't create new one
        HttpSession session = request.getSession(false);
        if (session == null || !"delivery".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in delivery person
        DeliveryPerson dp = (DeliveryPerson) session.getAttribute("deliveryPerson");
        if (dp == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        DeliveryPersonDao dao = new DeliveryPersonDao();

        // Fetch order counts
        Map<String, Integer> counts = dao.getOrderCounts(dp.getId());
        request.setAttribute("assignedCount", counts.getOrDefault("Assigned", 0));
        request.setAttribute("completedCount", counts.getOrDefault("Completed", 0));
        request.setAttribute("pendingCount", counts.getOrDefault("Pending", 0));

        // Fetch recent deliveries (fixed method call)
        request.setAttribute("assignedDeliveries", dao.getRecentDeliveries(dp.getId(), null));


        // Pass delivery person object for JSP
        request.setAttribute("deliveryPerson", dp);

        // Forward to JSP
        request.getRequestDispatcher("delivery-home.jsp").forward(request, response);
    }
}
