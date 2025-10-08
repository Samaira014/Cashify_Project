package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-home")
public class AdminHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);
        if(session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("admin-login.jsp");
            return;
        }
        
        try (Connection con = CashifyConnection.getCashifyConnection()) {

            // ===== Fetch Users =====
            List<Map<String, String>> users = new ArrayList<>();
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery("SELECT * FROM user");
            while(rs1.next()) {
                Map<String, String> user = new HashMap<>();
                user.put("id", rs1.getString("id"));
                user.put("name", rs1.getString("name"));
                user.put("email", rs1.getString("email"));
                user.put("phone", rs1.getString("phone"));
                user.put("joined_date", rs1.getString("joined_date"));
                users.add(user);
            }

            // ===== Fetch Sellers =====
            List<Map<String, String>> sellers = new ArrayList<>();
            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery("SELECT * FROM seller");
            while(rs2.next()) {
                Map<String, String> seller = new HashMap<>();
                seller.put("id", rs2.getString("id"));
                seller.put("name", rs2.getString("name"));
                seller.put("email", rs2.getString("email"));
                seller.put("phone", rs2.getString("phone"));
                seller.put("shop_name", rs2.getString("shop_name"));
                seller.put("status", rs2.getString("status"));
                sellers.add(seller);
            }

            // ===== Fetch Delivery Persons =====
            List<Map<String, String>> delivery = new ArrayList<>();
            Statement st3 = con.createStatement();
            ResultSet rs3 = st3.executeQuery("SELECT * FROM deliveryperson");
            while(rs3.next()) {
                Map<String, String> d = new HashMap<>();
                d.put("id", rs3.getString("id"));
                d.put("name", rs3.getString("name"));
                d.put("email", rs3.getString("email"));
                d.put("phone", rs3.getString("phone"));
                d.put("status", rs3.getString("status"));
                delivery.add(d);
            }

            // ===== Set Attributes =====
            request.setAttribute("users", users);
            request.setAttribute("sellers", sellers);
            request.setAttribute("deliverypersons", delivery);

            // ===== Forward to JSP =====
            RequestDispatcher rd = request.getRequestDispatcher("/admin-home.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
