package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;

import com.cashify.servlet_cashify_project.dao.SellOldPhoneDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(value = "/verifyOldPhone")
public class VerifyOldUserPhoneController extends HttpServlet {

	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        SellOldPhoneDao dao = new SellOldPhoneDao();
        boolean updated = dao.updateOldPhoneVerification(status, id); // returns true if updated successfully

        if (updated) {
            System.out.println("Phone ID " + id + " verification updated to: " + status);
        } else {
            System.out.println("Failed to update status for phone ID: " + id);
        }

        response.sendRedirect("user_old_phone.jsp");
    }
}