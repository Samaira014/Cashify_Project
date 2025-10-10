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
			String sql = "INSERT INTO product (id, seller_id, productName, brand, category, price, conditions, quantity, descriptions, image, discounted_price, rating, rejection_msg verified, joinedDateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, p.getId());
			ps.setInt(2, p.getSellerId());
			ps.setString(3, p.getProductName());
			ps.setString(4, p.getBrand());
			ps.setString(5, p.getCategory());
			ps.setDouble(6, p.getPrice());
			ps.setString(7, p.getCondition());
			ps.setInt(8, p.getQuantity());
			ps.setString(9, p.getDescription());
			ps.setBytes(10, p.getImage());
			ps.setDouble(11, p.getDiscountedPrice());
			ps.setString(12, p.getRejection_msg());
			ps.setDouble(13, p.getRating());
			ps.setBoolean(14, p.isVerified()); // or false if default
			ps.setTimestamp(15, Timestamp.valueOf(LocalDateTime.now()));

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
				p.setQuantity(rs.getInt("quantity"));
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
				p.setQuantity(rs.getInt("quantity"));
				p.setDescription(rs.getString("descriptions"));
				p.setImage(rs.getBytes("image"));
				p.setDiscountedPrice(rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : null);
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
			String sql = "UPDATE product SET productName=?, brand=?, category=?, price=?, conditions=?, quantity=?, descriptions=?, image=?, discounted_price=?, rating=?, rejection_msg=?, verified=? WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);

			ps.setString(1, p.getProductName());
			ps.setString(2, p.getBrand());
			ps.setString(3, p.getCategory());
			ps.setDouble(4, p.getPrice());
			ps.setString(5, p.getCondition());
			ps.setInt(6, p.getQuantity());
			ps.setString(7, p.getDescription());
			ps.setBytes(8, p.getImage());
			ps.setDouble(9, p.getDiscountedPrice());
			ps.setString(10, p.getRejection_msg());
			ps.setDouble(11, p.getRating());
			ps.setBoolean(12, p.isVerified());
			ps.setInt(13, p.getId());

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
	public boolean updateDiscountedPrice(int productId, double discountedPrice) {
	    String sql = "UPDATE product SET discounted_price=? WHERE id=?";
	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setDouble(1, discountedPrice);
	        ps.setInt(2, productId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// Verify a product
	public boolean verifyProduct(int productId) {
	    String sql = "UPDATE product SET verified=true, rejection_msg=NULL WHERE id=?";
	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setInt(1, productId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// Reject a product with reason
	public boolean rejectProduct(int productId, String reason) {
	    String sql = "UPDATE product SET verified=false, rejection_msg=? WHERE id=?";
	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setString(1, reason);
	        ps.setInt(2, productId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}
