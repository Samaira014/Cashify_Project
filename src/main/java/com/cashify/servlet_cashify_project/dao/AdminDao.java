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
}