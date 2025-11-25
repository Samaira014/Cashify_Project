package com.cashify.servlet_cashify_project.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;

public class WishlistDao {

    private Connection connection;

    public WishlistDao() {
        try {
            this.connection = CashifyConnection.getCashifyConnection(); // ✅ FIXED
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CHECK: is product in wishlist?
    public boolean isInWishlist(int userId, int productId) {
        String sql = "SELECT id FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ADD
    public boolean addToWishlist(int userId, int productId) {
        String sql = "INSERT INTO wishlist(user_id, product_id) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            return false; // ignore duplicates
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // REMOVE
    public boolean removeFromWishlist(int userId, int productId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // TOGGLE
    public boolean toggleWishlist(int userId, int productId) {
        if (isInWishlist(userId, productId)) {
            removeFromWishlist(userId, productId);
            return false;
        } else {
            addToWishlist(userId, productId);
            return true;
        }
    }

    // GET USER WISHLIST
    public List<Integer> getWishlistProducts(int userId) {
        List<Integer> products = new ArrayList<>();
        String sql = "SELECT product_id FROM wishlist WHERE user_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(rs.getInt("product_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
