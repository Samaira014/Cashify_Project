package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;
 // or Seller, depending on your login type
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addToCart")
public class AddToCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDao productDao = new ProductDao();

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession();

        // ✅ Step 1: Check login
        Object user = session.getAttribute("user"); // or "customer" depending on your login attribute name
        if (user == null) {
            // Not logged in → redirect to login page
            session.setAttribute("message", "Please login to add products to your cart.");
            resp.sendRedirect("login.jsp");
            return;
        }

        // ✅ Step 2: Cart management
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        String action = req.getParameter("action");
        int productId = Integer.parseInt(req.getParameter("productId"));
        Product product = productDao.getProductById(productId);

        if (product == null) {
            resp.sendRedirect("products");
            return;
        }

        if ("add".equals(action)) {
            // Avoid duplicate addition
            boolean alreadyInCart = cart.stream().anyMatch(p -> p.getId() == productId);
            if (!alreadyInCart) {
                cart.add(product);
            }
        } else if ("remove".equals(action)) {
            cart.removeIf(p -> p.getId() == productId);
        }

        session.setAttribute("cart", cart);

        // ✅ Step 3: Redirect back to cart page
        resp.sendRedirect("cart.jsp");
    }
}
