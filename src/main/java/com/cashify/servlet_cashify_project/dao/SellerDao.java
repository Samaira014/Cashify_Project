package com.cashify.servlet_cashify_project.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Seller;

public class SellerDao {

    private Connection connection = CashifyConnection.getCashifyConnection();

    //Register new seller
    public boolean registerSeller(Seller seller) {
        String query = "INSERT INTO seller (id, name, email, password, phone) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, seller.getId());
            ps.setString(2, seller.getName());
            ps.setString(3, seller.getEmail());
            ps.setString(4, seller.getPassword());
            ps.setLong(5, seller.getPhone());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Login seller
    public Seller loginSeller(String email, String password) {
        String query = "SELECT * FROM seller WHERE email = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Seller seller = new Seller();
                seller.setId(rs.getInt("id"));
                seller.setName(rs.getString("name"));
                seller.setEmail(rs.getString("email"));
                seller.setPassword(rs.getString("password"));
                seller.setPhone(rs.getLong("phone"));
                return seller;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Get seller by ID
    public Seller getSellerById(int id) {
        String query = "SELECT * FROM seller WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Seller seller = new Seller();
                seller.setId(rs.getInt("id"));
                seller.setName(rs.getString("name"));
                seller.setEmail(rs.getString("email"));
                seller.setPhone(rs.getLong("phone"));
                return seller;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Get all sellers
    public List<Seller> getAllSellers() {
        List<Seller> list = new ArrayList<>();
        String query = "SELECT * FROM seller";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Seller seller = new Seller();
                seller.setId(rs.getInt("id"));
                seller.setName(rs.getString("name"));
                seller.setEmail(rs.getString("email"));
                seller.setPhone(rs.getLong("phone"));
                list.add(seller);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Update seller details
    public boolean updateSeller(Seller seller) {
        String query = "UPDATE seller SET name=?, email=?, phone=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, seller.getName());
            ps.setString(2, seller.getEmail());
            ps.setLong(3, seller.getPhone());
            ps.setInt(4, seller.getId());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Delete seller by ID
    public boolean deleteSeller(int id) {
        String query = "DELETE FROM seller WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
