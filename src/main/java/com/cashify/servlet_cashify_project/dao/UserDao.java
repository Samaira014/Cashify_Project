package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Admin;
import com.cashify.servlet_cashify_project.dto.User;

public class UserDao {

	Connection connection = CashifyConnection.getCashifyConnection();

	public User saveUserDao(User user) {
		String insertInto = "INSERT INTO user(id, name, email, password, phone) VALUES (?, ?, ?, ?, ?)";

		try {

			// 3. Prepare the SQL statement
			PreparedStatement ps = connection.prepareStatement(insertInto);

			// 4. Set parameters from the User object
			ps.setInt(1, user.getId());
			ps.setString(2, user.getName());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getPassword());
			ps.setLong(5, user.getPhone());

			// 5. Execute the insert
			int rowsInserted = ps.executeUpdate();

			if (rowsInserted > 0) {
				System.out.println("User inserted successfully!");
				return user; // or return success flag or inserted ID
			}

			// Close connection
			ps.close();
			connection.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null; // return null if insert failed
	}
	
	public User getUserByEmailDao(String userEmail) {

		try {
			String selectAdminQueryByEmail = "select * from user where email = ?";

			PreparedStatement p = connection.prepareStatement(selectAdminQueryByEmail);
			
			p.setString(1, userEmail);
			
			ResultSet resultSet = p.executeQuery();
			if (resultSet.next()) {

				User user = new User();
				user.setId(resultSet.getInt("id"));
				user.setEmail(resultSet.getString("email"));
				user.setPassword(resultSet.getString("password"));
				user.setName(resultSet.getString("name"));
				user.setPhone(resultSet.getLong("phone"));;
				return user;
			}
			return null;
		} catch (SQLException e) {
			e.printStackTrace();

			return null;
		}

	}
}