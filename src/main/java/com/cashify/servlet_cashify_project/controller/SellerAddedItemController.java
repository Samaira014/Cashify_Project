package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.io.InputStream;

import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;
import com.cashify.servlet_cashify_project.dto.Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/SellerAddedItemController")
@MultipartConfig
public class SellerAddedItemController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            Seller seller = (Seller) session.getAttribute("seller");
            if (seller == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get form data
            String productName = request.getParameter("itemName");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");
            String model = request.getParameter("model");
            String color = request.getParameter("color");
            int ram = Integer.parseInt(request.getParameter("ram"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            String condition = request.getParameter("condition");
            String description = request.getParameter("description");

            // Handle image
            Part part = request.getPart("image");
            InputStream is = part.getInputStream();
            byte[] imageBytes = is.readAllBytes();

            // Create Product object
            Product p = new Product();
            p.setSellerId(seller.getId());
            p.setProductName(productName);
            p.setBrand(brand);
            p.setCategory(category);
            p.setModel(model);
            p.setColor(color);
            p.setRam(ram);
            p.setQuantity(quantity);
            p.setPrice(price);
            p.setCondition(condition);
            p.setDescription(description);
            p.setImage(imageBytes);

            // Save product using DAO
            ProductDao dao = new ProductDao();
            boolean isAdded = dao.addProduct(p);

            if (isAdded) {
                session.setAttribute("successMsg", "Product added successfully!");
                response.sendRedirect("seller-listing.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong while adding the product!");
                response.sendRedirect("seller-added-items.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session2 = request.getSession();
            session2.setAttribute("errorMsg", "Internal server error: " + e.getMessage());
            response.sendRedirect("seller-added-items.jsp");
        }
    }
}
