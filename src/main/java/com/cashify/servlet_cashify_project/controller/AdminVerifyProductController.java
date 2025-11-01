package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;


@WebServlet("/AdminVerifyProductController")
public class AdminVerifyProductController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        try (Connection con = CashifyConnection.getCashifyConnection()) {
            String sql = "UPDATE product SET verified = TRUE, rejection_msg = NULL WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
