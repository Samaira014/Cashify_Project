package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.DeliveryPerson;
import com.cashify.servlet_cashify_project.dto.Order;

public class DeliveryPersonDao {

	Connection connection = CashifyConnection.getCashifyConnection();

	// Save new delivery person
	public boolean saveDeliveryPerson(DeliveryPerson dp) {
		String query = "INSERT INTO deliveryperson (name, email, phone, password, status) VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setString(1, dp.getName());
			ps.setString(2, dp.getEmail());
			ps.setLong(3, dp.getPhone());
			ps.setString(4, dp.getPassword());
			ps.setString(5, dp.getStatus() != null ? dp.getStatus() : "Available");

			int rows = ps.executeUpdate();
			if (rows > 0) {
				ResultSet rs = ps.getGeneratedKeys();
				if (rs.next()) {
					dp.setId(rs.getInt(1));
				}
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Get delivery person by email
	public DeliveryPerson getByEmail(String email) {
		String query = "SELECT * FROM deliveryperson WHERE email=?";
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				DeliveryPerson dp = new DeliveryPerson();
				dp.setId(rs.getInt("id"));
				dp.setName(rs.getString("name"));
				dp.setEmail(rs.getString("email"));
				dp.setPhone(rs.getLong("phone"));
				dp.setPassword(rs.getString("password"));
				dp.setStatus(rs.getString("status"));
				dp.setJoined_date(rs.getTimestamp("joined_date"));
				return dp;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// Get all delivery persons
	public List<DeliveryPerson> getAllDeliveryPersons() {
		List<DeliveryPerson> list = new ArrayList<>();
		String query = "SELECT * FROM deliveryperson";
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				DeliveryPerson dp = new DeliveryPerson();
				dp.setId(rs.getInt("id"));
				dp.setName(rs.getString("name"));
				dp.setEmail(rs.getString("email"));
				dp.setPhone(rs.getLong("phone"));
				dp.setPassword(rs.getString("password"));
				dp.setStatus(rs.getString("status"));
				dp.setJoined_date(rs.getTimestamp("joined_date"));
				list.add(dp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// Update delivery person status
	public boolean updateStatus(int id, String status) {
		String query = "UPDATE deliveryperson SET status=? WHERE id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, status);
			ps.setInt(2, id);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Get assigned, completed, pending counts for a delivery person
	public Map<String, Integer> getOrderCounts(int deliveryPersonId) {
		Map<String, Integer> counts = new HashMap<>();
		counts.put("Assigned", 0);
		counts.put("Completed", 0);
		counts.put("Pending", 0);

		String sql = "SELECT payment_status AS status, COUNT(*) AS count " + "FROM orders " + "WHERE delivery_id = ? "
				+ "GROUP BY payment_status";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, deliveryPersonId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String status = rs.getString("status");
				int count = rs.getInt("count");

				// Map database status to dashboard keys
				switch (status) {
				case "Assigned":
					counts.put("Assigned", count);
					break;
				case "Completed":
					counts.put("Completed", count);
					break;
				case "Pending":
					counts.put("Pending", count);
					break;
				default:
					break; // ignore other statuses
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return counts;
	}

	// Fetch recent deliveries for a delivery person, optional status filter
    public List<Order> getRecentDeliveries(int deliveryPersonId, String status) {
        List<Order> deliveries = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE delivery_id = ?";

        // Add status filter if provided
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }

        sql += " ORDER BY order_date DESC LIMIT 10"; // fetch recent 10 deliveries

        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setInt(1, deliveryPersonId);
            if (status != null && !status.isEmpty()) {
                pst.setString(2, status);
            }

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserid(rs.getInt("user_id"));
                order.setProduct_id(rs.getInt("product_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setPayment_status(rs.getString("status"));
                order.setOrder_date(rs.getTimestamp("order_date"));
                deliveries.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deliveries;
    }
}