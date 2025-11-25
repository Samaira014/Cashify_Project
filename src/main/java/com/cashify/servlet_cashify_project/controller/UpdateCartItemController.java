package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.CartItemDao;
import com.cashify.servlet_cashify_project.dto.CartItems;
import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateCartItem")
public class UpdateCartItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartItemDao cartItemDao = new CartItemDao();
    private ProductDao productDao = new ProductDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // ✅ Get existing cart item details
            CartItems cartItem = cartItemDao.getCartItemsByItemsIdDao(itemId);
            if (cartItem == null) {
                response.sendRedirect("cart.jsp");
                return;
            }

            // ✅ Fetch product price
            Product product = productDao.getProductById(cartItem.getProductid());
            if (product == null) {
                response.sendRedirect("cart.jsp");
                return;
            }

            // ✅ Calculate new total price
            double newPrice = product.getPrice() * quantity;

            // ✅ Update in DB
            boolean updated = cartItemDao.updateCartItemsQuantityAndPriceDao(quantity, newPrice, itemId);

            if (updated) {
                session.setAttribute("message", "Cart updated successfully!");
            } else {
                session.setAttribute("message", "Failed to update cart.");
            }

            // ✅ Redirect back to cart page
            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp");
        }
    }
}
