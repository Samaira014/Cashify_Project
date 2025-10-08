package com.cashify.servlet_cashify_project.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import com.cashify.servlet_cashify_project.dao.SellOldPhoneDao;
import com.cashify.servlet_cashify_project.dto.SellOldPhone;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/sellPhone")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class SellPhoneController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            long phone = Long.parseLong(request.getParameter("phone"));
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String storage = request.getParameter("storage");
            String condition = request.getParameter("conditions");
            String priceParam = request.getParameter("price");
            double price = 0.0;
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                price = Double.parseDouble(priceParam);
            }
            String comments = request.getParameter("comments");

            Part imagePart = request.getPart("image");
            byte[] imageBytes = null;
            if (imagePart != null) {
                try (InputStream is = imagePart.getInputStream()) {
                    imageBytes = is.readAllBytes();
                }
            }

            SellOldPhone sellOldPhone = new SellOldPhone();
            sellOldPhone.setName(name);
            sellOldPhone.setEmail(email);
            sellOldPhone.setPhone(phone);
            sellOldPhone.setBrand(brand);
            sellOldPhone.setModel(model);
            sellOldPhone.setStorage(storage);
            sellOldPhone.setConditions(condition);
            sellOldPhone.setExpectedprice(price);
            sellOldPhone.setComments(comments);
            sellOldPhone.setImage(imageBytes);

            SellOldPhoneDao dao = new SellOldPhoneDao();
            SellOldPhone savedPhone = dao.saveOldPhone(sellOldPhone);

            if (savedPhone != null) {
                System.out.println("Your item registered successfully");
                request.getRequestDispatcher("user_old_phone.jsp").forward(request, resp);
            } else {
                System.out.println("Something went wrong while saving your phone");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
        }
    }
}
