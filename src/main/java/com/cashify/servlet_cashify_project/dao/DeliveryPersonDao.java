package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.DeliveryPerson;

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
}
