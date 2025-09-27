
package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.User;

public class UserDao {

	Connection conn = CashifyConnection.getCashifyConnection();

	public User saveUserDao(User user) {
		String insertInto = "INSERT INTO user(id, name, email, password, phone) VALUES (?, ?, ?, ?, ?)";

		try {

			// 3. Prepare the SQL statement
			PreparedStatement ps = conn.prepareStatement(insertInto);

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
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null; // return null if insert failed
	}
}
