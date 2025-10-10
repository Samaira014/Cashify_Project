package com.cashify.servlet_cashify_project.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Order;

public class OrderDao {

    private Connection connection = CashifyConnection.getCashifyConnection();

    // Add New Order
    public boolean addOrder(Order order) {
        String query = "INSERT INTO orders (userid, seller_id, product_id, address, quantity, total_price, payment_status, coupon_code, delivery_note, delivery_date, created_at) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, order.getUserid());
            ps.setInt(2, order.getSeller_id());
            ps.setInt(3, order.getProduct_id());
            ps.setString(4, order.getAddress());
            ps.setInt(5, order.getQuantity());
            ps.setDouble(6, order.getTotal_price());
            ps.setString(7, order.getPayment_status());
            ps.setString(8, order.getCoupon_code());
            ps.setString(9, order.getDelivery_note());
            ps.setDate(10, order.getDelivery_date());
            ps.setTimestamp(11, order.getCreated_at());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error adding new order: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get Order by ID
    public Order getOrderById(int id) {
        String query = "SELECT * FROM orders WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapOrder(rs);
        } catch (SQLException e) {
            System.err.println("❌ Error fetching order by ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get All Orders
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching all orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Update Payment Status
    public boolean updatePaymentStatus(int orderId, String status) {
        String query = "UPDATE orders SET payment_status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating payment status for order " + orderId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete Order
    public boolean deleteOrder(int id) {
        String query = "DELETE FROM orders WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error deleting order " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /* ---------------------- FILTER METHODS ---------------------- */

    // ✅ Get Orders by User ID (for user's order history)
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE userid = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching orders for user " + userId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Get Orders by Seller ID (for seller dashboard)
    public List<Order> getOrdersBySellerId(int sellerId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE seller_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching orders for seller " + sellerId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Get Orders by Payment Status
    public List<Order> getOrdersByPaymentStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE payment_status = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching orders with status " + status + ": " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Get Orders by Delivery Date
    public List<Order> getOrdersByDeliveryDate(Date deliveryDate) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE delivery_date = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, deliveryDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching orders for delivery date: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Fetch pending delivery orders
    public List<Order> getPendingOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE payment_status = 'Pending'";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching pending orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ Fetch returned orders
    public List<Order> getReturnedOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE delivery_note LIKE '%return%' OR payment_status = 'Returned'";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.err.println("❌ Error fetching returned orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    /* ---------------------- SAFE MAPPER ---------------------- */

    // ✅ Safe mapping of ResultSet → Order object
    private Order mapOrder(ResultSet rs) {
        Order order = new Order();
        try {
            order.setId(rs.getInt("id"));
            order.setUserid(rs.getInt("userid"));
            order.setSeller_id(rs.getInt("seller_id"));
            order.setProduct_id(rs.getInt("product_id"));

            String address = rs.getString("address");
            order.setAddress(address != null ? address : "N/A");

            order.setQuantity(rs.getInt("quantity"));
            order.setTotal_price(rs.getDouble("total_price"));

            String paymentStatus = rs.getString("payment_status");
            order.setPayment_status(paymentStatus != null ? paymentStatus : "Unknown");

            String coupon = rs.getString("coupon_code");
            order.setCoupon_code(coupon != null ? coupon : "");

            String deliveryNote = rs.getString("delivery_note");
            order.setDelivery_note(deliveryNote != null ? deliveryNote : "");

            java.sql.Date deliveryDate = rs.getDate("delivery_date");
            order.setDelivery_date(deliveryDate);

            java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
            order.setCreated_at(createdAt != null ? createdAt : new java.sql.Timestamp(System.currentTimeMillis()));

        } catch (SQLException e) {
            System.err.println("❌ Error mapping ResultSet to Order: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception ex) {
            System.err.println("⚠️ Unexpected mapping error: " + ex.getMessage());
            ex.printStackTrace();
        }
        return order;
    }
    
 // ✅ Update Delivery Details (delivery note + date)
    public boolean updateDeliveryDetails(int orderId, String deliveryNote, Date deliveryDate) {
        String query = "UPDATE orders SET delivery_note = ?, delivery_date = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, deliveryNote);
            ps.setDate(2, deliveryDate);
            ps.setInt(3, orderId);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                System.out.println("✅ Delivery details updated for order ID: " + orderId);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error updating delivery details for order " + orderId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
 // Example: Get all orders with sorting
    public List<Order> getAllOrders(String sortField, String sortDir) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders";
        if(sortField != null && sortDir != null){
            query += " ORDER BY " + sortField + " " + sortDir;
        }

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserid(rs.getInt("userid"));
                o.setProduct_id(rs.getInt("product_id"));
                o.setQuantity(rs.getInt("quantity"));
                o.setTotal_price(rs.getDouble("total_price"));
                o.setPayment_status(rs.getString("status"));
                o.setDelivery_note(rs.getString("delivery_note"));
                o.setDelivery_date(rs.getDate("delivery_date"));
                orders.add(o);
            }
            rs.close(); ps.close();
        } catch(Exception e){ e.printStackTrace(); }
        return orders;
    }

}
