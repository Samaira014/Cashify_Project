package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.util.List;

import com.cashify.servlet_cashify_project.dao.SalesDao;
import com.cashify.servlet_cashify_project.dto.SalesReport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sales")
public class SalesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SalesDao salesDao = new SalesDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SalesReport> salesList;
        String sellerIdParam = request.getParameter("sellerId");

        if (sellerIdParam != null && !sellerIdParam.isEmpty()) {
            try {
                int sellerId = Integer.parseInt(sellerIdParam);
                salesList = salesDao.getSalesBySellerId(sellerId);
            } catch (NumberFormatException e) {
                // Invalid input, show all sales
                salesList = salesDao.getAllSales();
            }
        } else {
            salesList = salesDao.getAllSales();
        }

        request.setAttribute("salesList", salesList);
        request.getRequestDispatcher("seller-sales-report.jsp").forward(request, response);
    }
}
