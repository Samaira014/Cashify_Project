package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.util.List;

import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dao.SellerDao;
import com.cashify.servlet_cashify_project.dto.Product;
import com.cashify.servlet_cashify_project.dto.Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin-seller")
public class AdminSellerController extends HttpServlet {

	private static final long serialVersionUID = 1L;

    private final SellerDao sellerDao = new SellerDao();
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Optional: If admin clicked on a specific seller
        String sellerIdParam = request.getParameter("sellerId");

        // Always load all sellers
        List<Seller> sellers = sellerDao.getAllSellers();
        int totalSellers = sellerDao.getTotalSellers();

        // ✅ If a specific seller is selected, show their products only
        if (sellerIdParam != null && !sellerIdParam.isEmpty()) {
            try {
                int sellerId = Integer.parseInt(sellerIdParam);
                List<Product> sellerProducts = productDao.getProductsBySellerId(sellerId);

                request.setAttribute("sellerProducts", sellerProducts);
                request.setAttribute("selectedSeller", sellerDao.getSellerById(sellerId));

            } catch (NumberFormatException e) {
                System.out.println("⚠ Invalid sellerId parameter: " + sellerIdParam);
            }
        }

        // ✅ Product counts for dashboard cards
        int pendingCount = productDao.countProductsByStatus("pending");
        int approvedCount = productDao.countProductsByStatus("approved");
        int rejectedCount = productDao.countProductsByStatus("rejected");
        int soldCount = productDao.countProductsByStatus("sold");

        // ✅ Products by status
        List<Product> pendingProducts = productDao.getProductsByStatus("pending");
        List<Product> approvedProducts = productDao.getProductsByStatus("approved");
        List<Product> rejectedProducts = productDao.getProductsByStatus("rejected");
        List<Product> soldProducts = productDao.getProductsByStatus("sold");

        // ✅ Set attributes for JSP
        request.setAttribute("sellers", sellers);
        request.setAttribute("totalSellers", totalSellers);
        request.setAttribute("pendingProducts", pendingProducts);
        request.setAttribute("approvedProducts", approvedProducts);
        request.setAttribute("rejectedProducts", rejectedProducts);
        request.setAttribute("soldProducts", soldProducts);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);
        request.setAttribute("soldCount", soldCount);

        // ✅ Forward to JSP
        request.getRequestDispatcher("admin-seller.jsp").forward(request, response);
    }
}