package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Admin;

public class AdminDao {

	Connection connection = CashifyConnection.getCashifyConnection();

	public Admin getAdminByEmailDao(String adminEmail) {

		try {
			String selectAdminQueryByEmail = "select * from admin where email = ?";

			PreparedStatement p = connection.prepareStatement(selectAdminQueryByEmail);
			
			p.setString(1, adminEmail);
			
			ResultSet resultSet = p.executeQuery();
			if (resultSet.next()) {

				Admin admin = new Admin();
				admin.setId(resultSet.getInt("id"));           // set ID
		        admin.setName(resultSet.getString("name"));
				admin.setEmail(resultSet.getString("email"));
				admin.setPassword(resultSet.getString("password"));

				return admin;
			}
			return null;
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}

	}
	
	 // ✅ Register (Insert new Admin)
    public Admin saveAdmin(Admin admin) {
        try {
            String insertQuery = "INSERT INTO admin (id,name, email, password) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(insertQuery);

            ps.setInt(1, admin.getId());
            ps.setString(2, admin.getName());
            ps.setString(3, admin.getEmail());
            ps.setString(4, admin.getPassword());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                return admin; // return saved object
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}