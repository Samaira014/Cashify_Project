package com.cashify.servlet_cashify_project.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.SellOldPhone;

public class SellOldPhoneDao {

    Connection connection = CashifyConnection.getCashifyConnection();

    // Save old phone to DB
    public SellOldPhone saveOldPhone(SellOldPhone oldPhone) {
        String insertQueryOldPhone = 
            "INSERT INTO old_phone(name, email, phone, brand, model, storage, conditions, expectedprice, comments, image, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement p = connection.prepareStatement(insertQueryOldPhone);
            p.setString(1, oldPhone.getName());
            p.setString(2, oldPhone.getEmail());
            p.setLong(3, oldPhone.getPhone());
            p.setString(4, oldPhone.getBrand());
            p.setString(5, oldPhone.getModel());
            p.setString(6, oldPhone.getStorage());
            p.setString(7, oldPhone.getConditions());
            p.setDouble(8, oldPhone.getExpectedprice());
            p.setString(9, oldPhone.getComments());
            p.setBytes(10, oldPhone.getImage());
            p.setString(11, "Not Verified");

            System.out.println("old phone added");
            return p.executeUpdate() != 0 ? oldPhone : null;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Retrieve all old phones
    public List<SellOldPhone> getAllOldPhones() {
        List<SellOldPhone> oldPhones = new ArrayList<>();
        String query = "SELECT * FROM old_phone";

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SellOldPhone phone = new SellOldPhone();
                phone.setId(rs.getInt("id"));
                phone.setName(rs.getString("name"));
                phone.setEmail(rs.getString("email"));
                phone.setPhone(rs.getLong("phone"));
                phone.setBrand(rs.getString("brand"));
                phone.setModel(rs.getString("model"));
                phone.setStorage(rs.getString("storage"));
                phone.setConditions(rs.getString("conditions"));
                phone.setExpectedprice(rs.getDouble("expectedprice"));
                phone.setComments(rs.getString("comments"));
                phone.setImage(rs.getBytes("image"));
                phone.setStatus(rs.getString("status"));
                oldPhones.add(phone);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return oldPhones;
    }

    public boolean updateOldPhoneVerification(String verify, int id) {
        try {
            String sql = "UPDATE old_phone SET status = ? WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, verify);
            ps.setInt(2, id);
            return ps.executeUpdate() != 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public SellOldPhone getOldPhoneByIdDao(int productId) {

		String query = "SELECT * FROM old_phone where id=?";

		try {
			PreparedStatement p = connection.prepareStatement(query);

			p.setInt(1, productId);

			ResultSet rs = p.executeQuery();

			if (rs.next()) {

				SellOldPhone phone = new SellOldPhone();

				phone.setId(rs.getInt("id"));
				phone.setName(rs.getString("name"));
				phone.setEmail(rs.getString("email"));
				phone.setPhone(rs.getLong("phone"));
				phone.setBrand(rs.getString("brand"));
				phone.setModel(rs.getString("model"));
				phone.setStorage(rs.getString("storage"));
				phone.setConditions(rs.getString("conditions")); // Note: changed from 'condition' to 'conditions'
				phone.setExpectedprice(rs.getDouble("expectedprice"));
				phone.setComments(rs.getString("comments"));
				phone.setImage(rs.getBytes("image"));
				phone.setStatus(rs.getString("status"));

				return phone;
			}

			return null;
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}
	}

	public double getOldPhonePriceByIdDao(int productId) {

		String query = "SELECT expected_price FROM old_phone where id=?";

		try {
			PreparedStatement p = connection.prepareStatement(query);

			p.setInt(1, productId);

			ResultSet rs = p.executeQuery();

			if (rs.next()) {

				

				 // Note: changed from 'condition' to 'conditions'
				return rs.getDouble("expectedprice");

			}

			return 0;
		} catch (SQLException e) {
			e.printStackTrace();

			return 0;
		}
	}

}
