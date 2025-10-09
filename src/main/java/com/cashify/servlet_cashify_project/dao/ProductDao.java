package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Product;

public class ProductDao {
	private Connection connection = CashifyConnection.getCashifyConnection();

	// Add Product
	public boolean addProduct(Product p) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO product (id, seller_id, productName, brand, category, price, conditions, descriptions, image, discounted_price, rating, verified, joinedDateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, p.getId());
			ps.setInt(2, p.getSellerId());
			ps.setString(3, p.getProductName());
			ps.setString(4, p.getBrand());
			ps.setString(5, p.getCategory());
			ps.setDouble(6, p.getPrice());
			ps.setString(7, p.getCondition());
			ps.setString(8, p.getDescription());
			ps.setBytes(9, p.getImage());
			ps.setDouble(10, p.getDiscountedPrice());
			ps.setDouble(11, p.getRating());
			ps.setBoolean(12, p.isVerified()); // or false if default
			ps.setTimestamp(13, Timestamp.valueOf(LocalDateTime.now()));

			int i = ps.executeUpdate();
			if (i > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Get all products by seller
	public List<Product> getProductsBySellerId(int sellerId) {
		List<Product> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM product WHERE seller_id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, sellerId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setSellerId(rs.getInt("seller_id"));
				p.setProductName(rs.getString("productName"));
				p.setBrand(rs.getString("brand"));
				p.setCategory(rs.getString("category"));
				p.setPrice(rs.getDouble("price"));
				p.setCondition(rs.getString("conditions"));
				p.setDescription(rs.getString("descriptions"));
				p.setImage(rs.getBytes("image"));
				p.setDiscountedPrice(rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : 0.0);
				p.setRating(rs.getDouble("rating"));
				p.setVerified(rs.getBoolean("verified"));
				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Get all products (for Admin)
	public List<Product> getAllProducts() {
		List<Product> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM product";
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setSellerId(rs.getInt("seller_id"));
				p.setProductName(rs.getString("productName"));
				p.setBrand(rs.getString("brand"));
				p.setCategory(rs.getString("category"));
				p.setPrice(rs.getDouble("price"));
				p.setCondition(rs.getString("conditions"));
				p.setDescription(rs.getString("descriptions"));
				p.setImage(rs.getBytes("image"));
				p.setDiscountedPrice(
						rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : null);
				p.setRating(rs.getDouble("rating"));
				p.setVerified(rs.getBoolean("verified"));
				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Update existing product
	public boolean updateProduct(Product p) {
		boolean flag = false;
		try {
			String sql = "UPDATE product SET productName=?, brand=?, category=?, price=?, conditions=?, descriptions=?, image=?, discounted_price=?, rating=?, verified=? WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);

			ps.setString(1, p.getProductName());
			ps.setString(2, p.getBrand());
			ps.setString(3, p.getCategory());
			ps.setDouble(4, p.getPrice());
			ps.setString(5, p.getCondition());
			ps.setString(6, p.getDescription());
			ps.setBytes(7, p.getImage());
			ps.setDouble(8, p.getDiscountedPrice());
			ps.setDouble(9, p.getRating());
			ps.setBoolean(10, p.isVerified());
			ps.setInt(11, p.getId());

			int i = ps.executeUpdate();
			if (i > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Delete product by ID
	public boolean deleteProduct(int id) {
		boolean flag = false;
		try {
			String sql = "DELETE FROM product WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
