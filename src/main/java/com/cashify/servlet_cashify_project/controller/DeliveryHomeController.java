package com.cashify.servlet_cashify_project.controller;
import java.io.IOException;
import com.cashify.servlet_cashify_project.dao.DeliveryPersonDao;
import com.cashify.servlet_cashify_project.dto.DeliveryPerson;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delivery-home")
public class DeliveryHomeController  extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"delivery".equals(session.getAttribute("role"))) {
            response.sendRedirect("delivery-login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        DeliveryPersonDao dao = new DeliveryPersonDao();
        DeliveryPerson dp = dao.getByEmail(email);

        request.setAttribute("deliveryName", dp != null ? dp.getName() : "Delivery Person");

        // You can also fetch assigned deliveries for this delivery person here
        // Example: request.setAttribute("assignedDeliveries", deliveryList);

        RequestDispatcher rd = request.getRequestDispatcher("delivery-home.jsp");
        rd.forward(request, response);
    }
}
